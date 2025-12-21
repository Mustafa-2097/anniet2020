class ProfileResponse {
  final bool success;
  final int statusCode;
  final String message;
  final UserData data;

  ProfileResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class UserData {
  final String id;
  final String email;
  final String role;
  final String status;
  final bool verified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserProfile profile;

  UserData({
    required this.id,
    required this.email,
    required this.role,
    required this.status,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
    required this.profile,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      verified: json['verified'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      profile: UserProfile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
}

class UserProfile {
  final String name;
  final String phone;
  final String? avatar;
  final bool subscribed;
  final DateTime? paidAt;

  UserProfile({
    required this.name,
    required this.phone,
    this.avatar,
    required this.subscribed,
    this.paidAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'],
      subscribed: json['subscribed'] as bool,
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'avatar': avatar,
      'subscribed': subscribed,
      'paidAt': paidAt?.toIso8601String(),
    };
  }
}
