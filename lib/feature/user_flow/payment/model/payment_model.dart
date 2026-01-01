class PaymentPageResponse {
  final bool success;
  final int statusCode;
  final String message;
  final PaymentUserData data;

  PaymentPageResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PaymentPageResponse.fromJson(Map<String, dynamic> json) {
    return PaymentPageResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: PaymentUserData.fromJson(json['data']),
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

class PaymentUserData {
  final String title;
  final String? thumbnail;
  final String? description;
  final double price;
  final int lessons;
  final int totalTime;

  PaymentUserData({
    required this.title,
    this.thumbnail,
    this.description,
    required this.price,
    required this.lessons,
    required this.totalTime,
  });

  factory PaymentUserData.fromJson(Map<String, dynamic> json) {
    return PaymentUserData(
      title: json['title'],
      thumbnail: json['thumbnail'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      lessons: json['lessons'],
      totalTime: json['totalTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumbnail': thumbnail,
      'description': description,
      'price': price,
      'lessons': lessons,
      'totalTime': totalTime,
    };
  }
}
