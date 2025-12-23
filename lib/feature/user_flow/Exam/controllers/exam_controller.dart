import 'package:get/get.dart';
import '../../lessons/controllers/lessons_controller.dart';
import '../../lessons/models/lesson_model.dart';
import '../../score/models/score_model.dart';
import '../../score/views/score_page.dart';
import '../../online_class/views/online_class_page.dart';
import '../../lessons/views/lessons_page.dart';
import '../model/exam_question_model.dart';

class ExamController extends GetxController {
  final String courseId;
  final String lessonId;

  late final LessonsController lessonsController;

  ExamController({
    required this.courseId,
    required this.lessonId,
  });

  static const int questionsPerVideo = 5;
  static const int passMark = 4;

  /// ================= STATE =================
  final questions = <ExamQuestionModel>[].obs;
  final currentIndex = 0.obs;
  final selectedIndex = (-1).obs;
  final isAnswered = false.obs;
  final isCorrect = false.obs;
  final score = 0.obs;

  /// ================= GETTERS =================
  int get totalQuestions => questions.length;

  double get progress => (currentIndex.value + 1) / totalQuestions;

  ExamQuestionModel get question =>
      questions[currentIndex.value];

  LessonModel get lesson =>
      lessonsController.lessons.firstWhere(
            (l) => l.id == lessonId,
      );

  /// ================= INIT =================
  @override
  void onInit() {
    super.onInit();

    lessonsController =
        Get.find<LessonsController>(tag: courseId);

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

  /// ================= ACTIONS =================
  void selectOption(int index) {
    if (isAnswered.value) return;
    selectedIndex.value = index;
  }

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

  Future<void> nextQuestion() async {
    if (currentIndex.value == questionsPerVideo - 1) {
      final isPassed = score.value >= passMark;

      if (isPassed) {
        // 🔥 STEP 1: tell backend to move to next video
        await lessonsController.getNextVideo(courseId);

        // 🔥 STEP 2: refresh lessons from backend
        await lessonsController.refreshFromBackend();
      }

      Get.offAll(() => ScorePage(
        courseId: courseId,
        result: ScoreData(
          score: score.value,
          total: questionsPerVideo,
          isPassed: isPassed,
        ),
        onNext: isPassed ? goToNextLesson : retryExam,
      ));
      return;
    }

    currentIndex.value++;
    selectedIndex.value = -1;
    isAnswered.value = false;
    isCorrect.value = false;
  }

  void retryExam() {
    Get.offAll(() => OnlineClassPage(
      courseId: courseId,
      lessonId: lessonId,
    ));
  }

  void goToNextLesson() {
    final lessons = lessonsController.lessons;
    final index = lessons.indexWhere((l) => l.id == lessonId);

    if (index != -1 &&
        index + 1 < lessons.length &&
        !lessons[index + 1].isLocked) {
      Get.offAll(() => OnlineClassPage(
        courseId: courseId,
        lessonId: lessons[index + 1].id,
      ));
    } else {
      Get.offAll(() => LessonsPage(courseId: courseId));
    }
  }
}
