class EducateEmployeeResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Pagination pagination;
  final List<EducateEmployeeData> data;

  EducateEmployeeResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory EducateEmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EducateEmployeeResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => EducateEmployeeData.fromJson(e))
          .toList(),
    );
  }
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
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

class EducateEmployeeData {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatar;
  final String message;
  final String? company;
  final int? employeeCount;
  final DateTime createdAt;

  EducateEmployeeData({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatar,
    required this.message,
    this.company,
    this.employeeCount,
    required this.createdAt,
  });

  factory EducateEmployeeData.fromJson(Map<String, dynamic> json) {
    return EducateEmployeeData(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'],
      avatar: json['avatar'],
      message: json['message'] ?? '',
      company: json['company'],
      employeeCount: json['employee_count'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
