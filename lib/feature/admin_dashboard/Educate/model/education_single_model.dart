class SingleContactResponse {
  final bool success;
  final int statusCode;
  final String message;
  final SingleContactData data;

  SingleContactResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SingleContactResponse.fromJson(Map<String, dynamic> json) {
    return SingleContactResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: SingleContactData.fromJson(json['data'] ?? {}),
    );
  }
}

class SingleContactData {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatar;
  final String message;
  final String? company;
  final int? employeeCount;
  dynamic createdAt;

  SingleContactData({
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

  factory SingleContactData.fromJson(Map<String, dynamic> json) {
    return SingleContactData(
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
