// payment_detail_model.dart

class PaymentDetailResponse {
  final bool success;
  final int statusCode;
  final String message;
  final PaymentDataWrapper data;

  PaymentDetailResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PaymentDetailResponse.fromJson(Map<String, dynamic> json) {
    return PaymentDetailResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: PaymentDataWrapper.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data.toJson(),
  };
}

class PaymentDataWrapper {
  final String message;
  final PaymentDetail data;

  PaymentDataWrapper({
    required this.message,
    required this.data,
  });

  factory PaymentDataWrapper.fromJson(Map<String, dynamic> json) {
    return PaymentDataWrapper(
      message: json['message'] as String,
      data: PaymentDetail.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data.toJson(),
  };
}

class PaymentDetail {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final double amount;
  final DateTime? paidAt;
  final String status;
  final String? transactionId;
  final List<CourseData> coursesData;

  PaymentDetail({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    required this.amount,
    this.paidAt,
    required this.status,
    this.transactionId,
    required this.coursesData,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      amount: (json['amount'] as num).toDouble(),
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
      status: json['status'] as String,
      transactionId: json['transactionId'] as String?,
      coursesData: (json['coursesData'] as List)
          .map((e) => CourseData.fromJson(e))
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
    'paidAt': paidAt?.toIso8601String(),
    'status': status,
    'transactionId': transactionId,
    'coursesData': coursesData.map((e) => e.toJson()).toList(),
  };
}

class CourseData {
  final String id;
  final String title;
  final int totalLengthInMinutes;

  CourseData({
    required this.id,
    required this.title,
    required this.totalLengthInMinutes,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'] as String,
      title: json['title'] as String,
      totalLengthInMinutes: json['totalLengthInMinutes'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'totalLengthInMinutes': totalLengthInMinutes,
  };
}
