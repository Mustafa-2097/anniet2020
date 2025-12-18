// course_review_model.dart
class CourseReviewResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Pagination pagination;
  final ReviewData data;

  CourseReviewResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory CourseReviewResponse.fromJson(Map<String, dynamic> json) {
    return CourseReviewResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      pagination: Pagination.fromJson(json['pagination']),
      data: ReviewData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'pagination': pagination.toJson(),
    'data': data.toJson(),
  };
}

class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
      totalPage: json['totalPage'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'total': total,
    'totalPage': totalPage,
  };
}

class ReviewData {
  final List<Review> reviews;
  final double average;
  final Map<String, int> counts;

  ReviewData({
    required this.reviews,
    required this.average,
    required this.counts,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      reviews: (json['reviews'] as List)
          .map((e) => Review.fromJson(e))
          .toList(),
      average: (json['average'] as num).toDouble(),
      counts: Map<String, int>.from(json['counts']),
    );
  }

  Map<String, dynamic> toJson() => {
    'reviews': reviews.map((e) => e.toJson()).toList(),
    'average': average,
    'counts': counts,
  };
}

class Review {
  final String id;
  final int rating;
  final String comment;
  final Lesson lesson;
  final DateTime createdAt;
  final User user;

  Review({
    required this.id,
    required this.rating,
    required this.comment,
    required this.lesson,
    required this.createdAt,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      lesson: Lesson.fromJson(json['lesson']),
      createdAt: DateTime.parse(json['createdAt']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'rating': rating,
    'comment': comment,
    'lesson': lesson.toJson(),
    'createdAt': createdAt.toIso8601String(),
    'user': user.toJson(),
  };
}

class Lesson {
  final String id;
  final int order;

  Lesson({
    required this.id,
    required this.order,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      order: json['order'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'order': order,
  };
}

class User {
  final String id;
  final String email;
  final String name;
  final String? avatar;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'avatar': avatar,
  };
}
