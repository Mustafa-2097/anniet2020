// contact_model.dart

class ContactResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Pagination pagination;
  final List<ContactData> data;

  ContactResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) {
    return ContactResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List)
          .map((e) => ContactData.fromJson(e))
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

class ContactData {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatar;
  final String message;
  final DateTime createdAt;

  ContactData({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatar,
    required this.message,
    required this.createdAt,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'phone': phone,
    'avatar': avatar,
    'message': message,
    'createdAt': createdAt.toIso8601String(),
  };
}