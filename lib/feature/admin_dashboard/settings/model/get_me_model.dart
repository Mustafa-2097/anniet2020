// admin_profile_model.dart

class AdminProfileResponse {
  final bool success;
  final int statusCode;
  final String message;
  final AdminData data;

  AdminProfileResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AdminProfileResponse.fromJson(Map<String, dynamic> json) {
    return AdminProfileResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: AdminData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data.toJson(),
  };
}

class AdminData {
  final String id;
  final String email;
  final String role;
  final String status;
  final bool verified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AdminProfile profile;

  AdminData({
    required this.id,
    required this.email,
    required this.role,
    required this.status,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
    required this.profile,
  });

  factory AdminData.fromJson(Map<String, dynamic> json) {
    return AdminData(
      id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      verified: json['verified'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      profile: AdminProfile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'role': role,
    'status': status,
    'verified': verified,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'profile': profile.toJson(),
  };
}

class AdminProfile {
  final String name;
  final String phone;
  final String? avatar;
  final bool subscribed;
  final DateTime? paidAt;

  AdminProfile({
    required this.name,
    required this.phone,
    this.avatar,
    required this.subscribed,
    this.paidAt,
  });

  factory AdminProfile.fromJson(Map<String, dynamic> json) {
    return AdminProfile(
      name: json['name'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String?,
      subscribed: json['subscribed'] as bool,
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'avatar': avatar,
    'subscribed': subscribed,
    'paidAt': paidAt?.toIso8601String(),
  };
}
