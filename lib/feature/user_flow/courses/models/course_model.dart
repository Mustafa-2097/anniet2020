class Course {
  final String id;
  final String title;
  final String? description;
  final String? thumbnail;
  final int totalLessons;
  final int completedLessons;

  Course({
    required this.id,
    required this.title,
    this.description,
    this.thumbnail,
    required this.totalLessons,
    required this.completedLessons,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    final lessons = json['lessons'] as Map<String, dynamic>?;

    return Course(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'],
      thumbnail: json['thumbnail'],
      totalLessons: lessons?['count'] ?? 0,
      completedLessons: lessons?['completed'] ?? 0,
    );
  }
}
