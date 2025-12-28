import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../../data/repositories/user_repository.dart';
import '../../lessons/controllers/lessons_controller.dart';
import '../../lessons/views/lessons_page.dart';
import '../../online_class/views/online_class_page.dart';
import '../../score/models/score_model.dart';
import '../../score/views/score_page.dart';
import '../model/exam_question_model.dart';

class ExamController extends GetxController {
  final String courseId;
  final String lessonId;
  ExamController({required this.courseId, required this.lessonId});

  final UserRepository _repository = UserRepository();
  late final LessonsController lessonsController;

  /// ================= STATE =================
  final questions = <ExamQuestionModel>[].obs;
  final currentIndex = 0.obs;
  final selectedIndex = (-1).obs;
  final isAnswered = false.obs;
  final isCorrect = false.obs;
  final score = 0.obs;
  final isLoading = true.obs;
  final isNavigating = false.obs;

  /// ================= GETTERS =================
  int get totalQuestions => questions.length;

  double get progress => totalQuestions == 0 ? 0 : (currentIndex.value + 1) / totalQuestions;

  ExamQuestionModel get question => questions[currentIndex.value];

  /// ================= INIT =================
  @override
  void onInit() {
    super.onInit();
    lessonsController = Get.find<LessonsController>(tag: courseId);
    _loadQuestions();
  }

  /// ================= API =================
  Future<void> _loadQuestions() async {
    try {
      isLoading.value = true;
      final result = await _repository.getLessonQuestions(lessonId);
      questions.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", "Failed to load exam questions", backgroundColor: AppColors.redColor);
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= ACTIONS =================
  void selectOption(int index) {
    if (isAnswered.value) return;
    selectedIndex.value = index;
  }

  void checkAnswer() {
    if (selectedIndex.value == -1) return;

    isAnswered.value = true;
    isCorrect.value = selectedIndex.value == question.correctIndex;

    if (isCorrect.value) {
      score.value++;
    }
  }

  Future<void> nextQuestion() async {
    if (isNavigating.value) return;

    if (currentIndex.value == totalQuestions - 1) {
      isNavigating.value = true;
      EasyLoading.show(status: 'Checking result...');

      final bool isPassed = score.value >= totalQuestions;

      try {
        if (isPassed) {
          await lessonsController.getNextVideo(courseId);
          await lessonsController.refreshFromBackend();
        }

        EasyLoading.dismiss();
        Get.offAll(() => ScorePage(
          courseId: courseId,
          result: ScoreData(score: score.value, total: totalQuestions, isPassed: isPassed),
          onNext: isPassed ? goToNextLesson : retryExam,
        ));
      } catch (_) {
        EasyLoading.dismiss();
        isNavigating.value = false;
      }
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

    if (index != -1 && index + 1 < lessons.length) {
      Get.offAll(() => OnlineClassPage(
        courseId: courseId,
        lessonId: lessons[index + 1].id,
      ));
    } else {
      Get.offAll(() => LessonsPage(courseId: courseId));
    }
  }
}
