class LessonModel {
  final String id;
  final String title;
  final String image;
  final String? video;
  final int lengthInSeconds;
  final int order;
  final String description;

  /// These must be mutable
  bool isCompleted;
  bool isLocked;

  LessonModel({
    required this.id,
    required this.title,
    required this.image,
    required this.video,
    required this.lengthInSeconds,
    required this.order,
    required this.description,
    required this.isCompleted,
    this.isLocked = true,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'],
      image: json['thumbnail'],
      video: json['video'],
      lengthInSeconds: json['lengthInSeconds'] ?? 0,
      description: json['description'] ?? "",
      order: json['order'],
      isCompleted: json['completed'] ?? false,
    );
  }

  String get duration {
    final minutes = (lengthInSeconds / 60).ceil();
    return "$minutes min";
  }
}
