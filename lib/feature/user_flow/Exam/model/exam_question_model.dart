class ExamQuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;

  ExamQuestionModel({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}
