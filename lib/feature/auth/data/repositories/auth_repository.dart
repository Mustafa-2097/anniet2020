import 'package:flutter/material.dart';
import '../../../../core/offline_storage/shared_pref.dart';
import '../api_providers/auth_api_provider.dart';

class AuthRepository {
  final AuthApiProvider _provider = AuthApiProvider();

  /// Register (Sign-Up)
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _provider.register(
      name: name,
      email: email,
      password: password,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Registration failed');
    }
    // Optional: if backend sends OTP automatically, no extra call needed here
  }
  /// Verify Sign-Up OTP
  Future<void> verifySignUpOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _provider.verifySigUupOtp(email: email, otp: otp);

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'OTP verification failed');
    }
  }


  /// Login use-case
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await _provider.login(
      email: email,
      password: password,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Login failed');
    }

    final data = response['data'];
    final accessToken = data['accessToken'];

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token missing from response');
    }

    // MUST await
    await SharedPreferencesHelper.saveToken(accessToken);

    // Optional debug
    debugPrint('TOKEN SAVED: $accessToken');
  }


  /// Step 1: Send OTP
  Future<void> sendResetOtp(String email) async {
    final response = await _provider.sendResetOtp(email);

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to send OTP');
    }
  }

  /// Step 2: Verify OTP
  Future<String> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _provider.verifyResetOtp(
      email: email,
      otp: otp,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'OTP verification failed');
    }

    return response['data']['token'];
  }

  /// Step 3: Reset password
  Future<void> resetPassword({
    required String token,
    required String password,
  }) async {
    final response = await _provider.resetPassword(
      token: token,
      password: password,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Password reset failed');
    }
  }
}
