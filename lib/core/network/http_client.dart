import 'dart:convert';
import 'package:http/http.dart' as http;

import '../offline_storage/shared_pref.dart';

class HttpClient {
  final http.Client _client = http.Client();

  /// GET request
  Future<Map<String, dynamic>> get(String url) async {
    final response = await _client.get(
      Uri.parse(url),
      headers: await _headers(),
    );

    return _handleResponse(response);
  }

  /// POST request
  Future<Map<String, dynamic>> post(
      String url,
      Map<String, dynamic> body,
      ) async {
    final response = await _client.post(
      Uri.parse(url),
      headers: await _headers(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  /// Headers with access token
  Future<Map<String, String>> _headers() async {
    final token = await SharedPreferencesHelper.getToken();

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Central response handler
  Map<String, dynamic> _handleResponse(http.Response response) {
    final decoded = jsonDecode(response.body);

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      return decoded;
    }

    if (decoded is Map && decoded.containsKey('errorMessages')) {
      final errors = decoded['errorMessages'] as List;
      throw Exception(errors.first['message']);
    }

    throw Exception(decoded['message'] ?? 'Something went wrong');
  }
}
