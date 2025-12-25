class PaymentPageResponse {
  final bool success;
  final int statusCode;
  final String message;
  final PaymentData data;

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
      data: PaymentData.fromJson(json['data']),
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

class PaymentData {
  final String title;
  final String? thumbnail;
  final String? description;
  final double price;
  final int lessons;
  final int totalTime;

  PaymentData({
    required this.title,
    this.thumbnail,
    this.description,
    required this.price,
    required this.lessons,
    required this.totalTime,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
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
