// analytics_model.dart
class AnalyticsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final AnalyticsDataWrapper data;

  AnalyticsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AnalyticsResponse.fromJson(Map<String, dynamic> json) {
    return AnalyticsResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: AnalyticsDataWrapper.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data.toJson(),
  };
}

class AnalyticsDataWrapper {
  final String message;
  final AnalyticsData data;

  AnalyticsDataWrapper({
    required this.message,
    required this.data,
  });

  factory AnalyticsDataWrapper.fromJson(Map<String, dynamic> json) {
    return AnalyticsDataWrapper(
      message: json['message'] as String,
      data: AnalyticsData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data.toJson(),
  };
}

class AnalyticsData {
  final int totalRevenue;
  final int totalUsers;
  final int totalSell;
  final int totalCompleted;

  AnalyticsData({
    required this.totalRevenue,
    required this.totalUsers,
    required this.totalSell,
    required this.totalCompleted,
  });

  factory AnalyticsData.fromJson(Map<String, dynamic> json) {
    return AnalyticsData(
      totalRevenue: json['totalRevenue'] as int,
      totalUsers: json['totalUsers'] as int,
      totalSell: json['totalSell'] as int,
      totalCompleted: json['totalCompleted'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalRevenue': totalRevenue,
    'totalUsers': totalUsers,
    'totalSell': totalSell,
    'totalCompleted': totalCompleted,
  };
}
