import 'dart:convert';
import 'package:flutter/material.dart';
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
      Map<String, dynamic> body, {
        bool withAuth = true,
      }) async {
    final response = await _client.post(
      Uri.parse(url),
      headers: await _headers(withAuth: withAuth),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  /// PATCH request
  Future<Map<String, dynamic>> patch(
      String url,
      Map<String, dynamic> body, {
        bool withAuth = true,
      }) async {
    final response = await _client.patch(
      Uri.parse(url),
      headers: await _headers(withAuth: withAuth),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }


  /// Headers with optional access token
  Future<Map<String, String>> _headers({bool withAuth = true}) async {
    final token = await SharedPreferencesHelper.getToken();
    debugPrint('TOKEN SENT: $token');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (withAuth && token != null && token.isNotEmpty) {
      headers['Authorization'] = token;
    }

    return headers;
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
