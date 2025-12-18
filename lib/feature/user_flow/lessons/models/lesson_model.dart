class LessonModel {
  final String id;
  final String title;
  final String image;
  final int lengthInSeconds;
  final bool isCompleted;
  final int order;

  LessonModel({
    required this.id,
    required this.title,
    required this.image,
    required this.lengthInSeconds,
    required this.isCompleted,
    required this.order,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'],
      image: json['thumbnail'],
      lengthInSeconds: json['lengthInSeconds'],
      isCompleted: json['completed'],
      order: json['order'],
    );
  }

  String get duration {
    final minutes = (lengthInSeconds / 60).ceil();
    return "$minutes min";
  }

  /// lock logic
  bool get isLocked => !isCompleted && order != 1;
}
