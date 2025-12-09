import 'package:get/get.dart';
import '../../score/models/score_model.dart';
import '../../score/views/score_page.dart';
import '../model/exam_question_model.dart';
import '../views/exam_page.dart';

class ExamController extends GetxController {
  static ExamController get instance => Get.find();

  /// ================= CONFIG =================
  static const int questionsPerVideo = 5;
  static const int passMark = 3;

  /// ================= QUESTIONS =================
  final questions = <ExamQuestionModel>[].obs;
  @override
  void onInit() {
    super.onInit();
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

  final currentIndex = 0.obs;

  ExamQuestionModel get question => questions[currentIndex.value];
  int get totalQuestions => questionsPerVideo;

  /// ================= STATES =================
  final selectedIndex = (-1).obs;
  final isAnswered = false.obs;
  final isCorrect = false.obs;

  final score = 0.obs; /// Only for current video
  final progress = 0.0.obs;
  final lifeCount = 6.obs;

  /// Total successfully completed videos
  final completedVideos = 0.obs;

  ///
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
      lifeCount.value--;
    }
  }

  /// ================= NEXT QUESTION =================
  void nextQuestion() {
    /// Last question of this video
    if (currentIndex.value == questionsPerVideo - 1) {
      final bool isVideoPassed = score.value >= passMark;

      if (isVideoPassed) {
        completedVideos.value++; /// Only when video pass
      }

      goToResultPage(isVideoPassed);
      return;
    }

    currentIndex.value++;
    progress.value = currentIndex.value / questionsPerVideo;

    selectedIndex.value = -1;
    isAnswered.value = false;
    isCorrect.value = false;
  }

  /// ================= SCORE PAGE =================
  void goToResultPage(bool isVideoPassed) {
    Get.off(() => ScorePage(
      result: ScoreData(
        score: score.value,
        total: questionsPerVideo,
        isPassed: isVideoPassed,
        userName: "Tanvir Hossain",
        completedVideos: completedVideos.value,
      ),
      onNext: retryExam,
    ));
  }

  /// ================= RETRY =================
  void retryExam() {
    score.value = 0;
    lifeCount.value = 6;
    progress.value = 0;
    currentIndex.value = 0;

    selectedIndex.value = -1;
    isAnswered.value = false;
    isCorrect.value = false;

    Get.offAll(() => ExamPage());
  }
}
