class ReviewUserModel {
  final String id;
  final int rating;
  final String comment;
  final String userName;
  final String? avatar;
  final DateTime createdAt;

  ReviewUserModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.userName,
    required this.createdAt,
    this.avatar,
  });

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) {
    return ReviewUserModel(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      userName: json['user']['name'],
      avatar: json['user']['avatar'],
    );
  }
}

