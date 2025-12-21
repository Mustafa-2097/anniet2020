// payments_model.dart

class PaymentsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Pagination pagination;
  final List<PaymentData> data;

  PaymentsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory PaymentsResponse.fromJson(Map<String, dynamic> json) {
    return PaymentsResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List)
          .map((e) => PaymentData.fromJson(e))
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

class PaymentData {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final double amount;
  final DateTime? paidAt;
  final String status;
  final String? transactionId;

  PaymentData({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    required this.amount,
    this.paidAt,
    required this.status,
    this.transactionId,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      amount: (json['amount'] as num).toDouble(),
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
      status: json['status'] as String,
      transactionId: json['transactionId'] as String?,
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
  };
}
