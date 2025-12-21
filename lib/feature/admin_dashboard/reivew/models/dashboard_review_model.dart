class CourseReviewsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Pagination pagination;
  final CourseReviewsData data;

  CourseReviewsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory CourseReviewsResponse.fromJson(Map<String, dynamic> json) {
    return CourseReviewsResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
      data: CourseReviewsData.fromJson(json['data'] ?? {}),
    );
  }
}

/* ---------------- Pagination ---------------- */

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
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

/* ---------------- Main Data ---------------- */

class CourseReviewsData {
  final List<CourseReview> reviews;
  final double average;
  final Map<int, int> counts;

  CourseReviewsData({
    required this.reviews,
    required this.average,
    required this.counts,
  });

  factory CourseReviewsData.fromJson(Map<String, dynamic> json) {
    return CourseReviewsData(
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((e) => CourseReview.fromJson(e))
          .toList(),
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
      counts: (json['counts'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(int.parse(key), value as int)),
    );
  }
}

/* ---------------- Review Item ---------------- */

class CourseReview {
  final String id;
  final int rating;
  final String comment;
  final Lesson lesson;
  final DateTime createdAt;
  final ReviewUser user;

  CourseReview({
    required this.id,
    required this.rating,
    required this.comment,
    required this.lesson,
    required this.createdAt,
    required this.user,
  });

  factory CourseReview.fromJson(Map<String, dynamic> json) {
    return CourseReview(
      id: json['id'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      lesson: Lesson.fromJson(json['lesson'] ?? {}),
      createdAt: DateTime.parse(json['createdAt']),
      user: ReviewUser.fromJson(json['user'] ?? {}),
    );
  }
}

/* ---------------- Lesson ---------------- */

class Lesson {
  final String id;
  final int order;

  Lesson({
    required this.id,
    required this.order,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] ?? '',
      order: json['order'] ?? 0,
    );
  }
}

/* ---------------- Review User ---------------- */

class ReviewUser {
  final String id;
  final String email;
  final String name;
  final String? avatar;

  ReviewUser({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'],
    );
  }
}
