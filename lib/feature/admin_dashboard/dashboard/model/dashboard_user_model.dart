// users_model.dart

class UsersResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Pagination pagination;
  final List<UserData> data;

  UsersResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    return UsersResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List)
          .map((e) => UserData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'pagination': pagination.toJson(),
    'data': data.map((e) => e.toJson()).toList(),
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

class UserData {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final bool subscribed;
  final String course;
  final bool certification;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    required this.subscribed,
    required this.course,
    required this.certification,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      subscribed: json['subscribed'] as bool,
      course: json['course'] as String,
      certification: json['certification'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'avatar': avatar,
    'subscribed': subscribed,
    'course': course,
    'certification': certification,
  };
}
