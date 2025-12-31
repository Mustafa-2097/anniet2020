// user_detail_model.dart

class UserDetailResponse {
  final bool success;
  final int statusCode;
  final String message;
  final UserDetail data;

  UserDetailResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: UserDetail.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data.toJson(),
  };
}

class UserDetail {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  dynamic amount;
  final bool subscribed;
  final DateTime? paidAt;
  final bool certification;
  final List<CourseProgress> courseProgress;

  UserDetail({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.amount,
    required this.subscribed,
    this.paidAt,
    required this.certification,
    required this.courseProgress,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      amount: json['amount'],
      subscribed: json['subscribed'] as bool,
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
      certification: json['certification'] as bool,
      courseProgress: (json['courseProgress'] as List)
          .map((e) => CourseProgress.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'avatar': avatar,
    'amount': amount,
    'subscribed': subscribed,
    'paidAt': paidAt?.toIso8601String(),
    'certification': certification,
    'courseProgress': courseProgress.map((e) => e.toJson()).toList(),
  };
}

class CourseProgress {
  final String id;
  final String title;
  final LessonProgress lessons;
  dynamic progress;
  final bool completed;

  CourseProgress({
    required this.id,
    required this.title,
    required this.lessons,
    required this.progress,
    required this.completed,
  });

  factory CourseProgress.fromJson(Map<String, dynamic> json) {
    return CourseProgress(
      id: json['id'] as String,
      title: json['title'] as String,
      lessons: LessonProgress.fromJson(json['lessons']),
      progress: json['progress'],
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'lessons': lessons.toJson(),
    'progress': progress,
    'completed': completed,
  };
}

class LessonProgress {
  final int total;
  final int completed;

  LessonProgress({
    required this.total,
    required this.completed,
  });

  factory LessonProgress.fromJson(Map<String, dynamic> json) {
    return LessonProgress(
      total: json['total'] as int,
      completed: json['completed'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'completed': completed,
  };
}

