class ExamQuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final String answer;
  final int correctIndex;

  ExamQuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
    required this.correctIndex,
  });

  /// Factory from API json
  factory ExamQuestionModel.fromJson(Map<String, dynamic> json) {
    final List<String> options = List<String>.from(json['options']);
    final String answer = json['answer'];

    return ExamQuestionModel(
      id: json['id'],
      question: json['question'],
      options: options,
      answer: answer,
      correctIndex: options.indexOf(answer),
    );
  }
}
