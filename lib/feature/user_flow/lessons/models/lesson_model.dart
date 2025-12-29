class LessonModel {
  final String id;
  final String title;
  final String? thumbnail;
  final String? video;
  final int lengthInSeconds;
  final int order;
  final String description;
  final int questionsCount; // Added from API
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Mutable states (controlled by LessonsController)
  bool isCompleted;
  bool isLocked;

  LessonModel({
    required this.id,
    required this.title,
    this.thumbnail,
    this.video,
    required this.lengthInSeconds,
    required this.order,
    required this.description,
    required this.questionsCount, // Added
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isCompleted,
    this.isLocked = true,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'] ?? "",
      thumbnail: json['thumbnail'],
      video: json['video'],
      lengthInSeconds: json['lengthInSeconds'] ?? 0,
      order: json['order'] ?? 0,
      description: json['description'] ?? "",
      questionsCount: json['questionsCount'] ?? 0, // Added
      status: json['status'] ?? "ACTIVE",
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isCompleted: json['completed'] ?? false,
      isLocked: true,
    );
  }

  /// UI helper
  String get duration {
    final minutes = (lengthInSeconds / 60).ceil();
    return "$minutes min";
  }

  /// Helper to check if lesson has exam
  bool get hasExam => questionsCount > 0;
}