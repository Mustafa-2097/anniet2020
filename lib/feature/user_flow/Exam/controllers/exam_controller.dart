import 'package:anniet2020/feature/user_flow/lessons/views/lessons_page.dart';
import 'package:get/get.dart';
import '../../lessons/controllers/lessons_controller.dart';
import '../../lessons/models/lesson_model.dart';
import '../../score/models/score_model.dart';
import '../../score/views/score_page.dart';
import '../model/exam_question_model.dart';
import '../../online_class/views/online_class_page.dart';

class ExamController extends GetxController {
  static ExamController get instance => Get.find();

  /// ================= DEPENDENCIES =================
  final LessonModel lesson;
  final String courseId;
  late final LessonsController lessonsController;
  ExamController({required this.lesson, required this.courseId});

  /// ================= CONFIG =================
  static const int questionsPerVideo = 5;
  static const int passMark = 4; /// 4 out of 5 required

  /// ================= QUESTIONS =================
  final questions = <ExamQuestionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    lessonsController = Get.find<LessonsController>(tag: courseId);
    /// TODO: Later load questions dynamically from backend by lesson.id
    questions.assignAll([
      ExamQuestionModel(
        question: "What is the legal BAC limit?",
        options: ["0.10", "0.05", "0.02", "Zero"],
        correctIndex: 1,
      ),
      ExamQuestionModel(
        question: "When can you overtake?",
        options: ["Never", "Anytime", "When safe", "Only at night"],
        correctIndex: 2,
      ),
      ExamQuestionModel(
        question: "Red traffic light means?",
        options: ["Stop", "Go", "Speed up", "Slow down"],
        correctIndex: 0,
      ),
      ExamQuestionModel(
        question: "Seatbelt is required?",
        options: ["No", "Sometimes", "Yes", "Only highway"],
        correctIndex: 2,
      ),
      ExamQuestionModel(
        question: "Speed limit sign is?",
        options: ["Suggestion", "Warning", "Maximum speed", "Minimum speed"],
        correctIndex: 2,
      ),
    ]);
  }

  /// ================= STATE =================
  final currentIndex = 0.obs;
  final selectedIndex = (-1).obs;
  final isAnswered = false.obs;
  final isCorrect = false.obs;

  final score = 0.obs;
  final progress = 0.0.obs;

  /// ================= GETTERS =================
  ExamQuestionModel get question => questions[currentIndex.value];
  int get totalQuestions => questionsPerVideo;

  /// ================= OPTION SELECT =================
  void selectOption(int index) {
    if (isAnswered.value) return;
    selectedIndex.value = index;
  }

  /// ================= CHECK ANSWER =================
  void checkAnswer() {
    if (selectedIndex.value == -1) return;

    isAnswered.value = true;

    if (selectedIndex.value == question.correctIndex) {
      isCorrect.value = true;
      score.value++;
    } else {
      isCorrect.value = false;
    }
  }

  /// ================= NEXT QUESTION =================
  Future<void> nextQuestion() async {
    /// Last question
    if (currentIndex.value == questionsPerVideo - 1) {
      final bool isPassed = score.value >= passMark;

      if (isPassed) {
        lessonsController.markLessonCompleted(lesson.id);
        await lessonsController.syncNextVideoFromServer();
      }

      goToResultPage(isPassed);
      return;
    }

    /// Go next question
    currentIndex.value++;
    progress.value = currentIndex.value / questionsPerVideo;

    selectedIndex.value = -1;
    isAnswered.value = false;
    isCorrect.value = false;
  }

  /// ================= SCORE PAGE =================
  void goToResultPage(bool isPassed) {
    Get.off(() => ScorePage(
      result: ScoreData(
        score: score.value,
        total: questionsPerVideo,
        isPassed: isPassed,
        completedVideos: lessonsController.lessons
            .where((l) => l.isCompleted)
            .length,
      ),
      onNext: isPassed ? goToNextLesson : retryExam, courseId: courseId,
    ));
  }

  /// ================= RETRY SAME LESSON =================
  void retryExam() {
    score.value = 0;
    progress.value = 0;
    currentIndex.value = 0;

    selectedIndex.value = -1;
    isAnswered.value = false;
    isCorrect.value = false;

    Get.off(() => OnlineClassPage(
      courseId: lessonsController.courseId,
      lesson: lesson,
    ));
  }

  /// ================= NEXT LESSON =================
  void goToNextLesson() {
    final index =
    lessonsController.lessons.indexWhere((l) => l.id == lesson.id);
    if (index == -1) return;

    /// If next lesson exists → open it
    if (index + 1 < lessonsController.lessons.length) {
      final nextLesson = lessonsController.lessons[index + 1];

      Get.offAll(() => OnlineClassPage(
        courseId: lessonsController.courseId,
        lesson: nextLesson,
      ));
    } else {
      /// All lessons completed → back to lessons list
      Get.offAll(() => LessonsPage(courseId: courseId));
    }
  }
}
