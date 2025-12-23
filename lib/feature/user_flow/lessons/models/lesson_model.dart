class LessonModel {
  final String id;
  final String title;
  final String? image;
  final String? video;
  final int lengthInSeconds;
  final int order;
  final String description;

  /// Mutable states (controlled by LessonsController)
  bool isCompleted;
  bool isLocked;

  LessonModel({
    required this.id,
    required this.title,
    this.image,
    this.video,
    required this.lengthInSeconds,
    required this.order,
    required this.description,
    required this.isCompleted,
    this.isLocked = true,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'] ?? "",
      image: json['thumbnail'],
      video: json['video'],
      lengthInSeconds: json['lengthInSeconds'] ?? 0,
      order: json['order'] ?? 0,
      description: json['description'] ?? "",

      /// ✅ Backend is the ONLY source of completion
      isCompleted: json['completed'] ?? false,

      /// 🔒 Lock state will be calculated later
      isLocked: true,
    );
  }

  /// UI helper
  String get duration {
    final minutes = (lengthInSeconds / 60).ceil();
    return "$minutes min";
  }
}
