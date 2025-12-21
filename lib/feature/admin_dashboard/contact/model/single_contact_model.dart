// single_contact_model.dart

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
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: SingleContactData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data.toJson(),
  };
}

class SingleContactData {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatar;
  final String message;
  final DateTime createdAt;

  SingleContactData({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatar,
    required this.message,
    required this.createdAt,
  });

  factory SingleContactData.fromJson(Map<String, dynamic> json) {
    return SingleContactData(
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