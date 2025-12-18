class Course {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final int totalLessons;
  final int completedLessons;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.totalLessons,
    required this.completedLessons,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      totalLessons: json['lessons']['count'],
      completedLessons: json['lessons']['completed'],
    );
  }
}
