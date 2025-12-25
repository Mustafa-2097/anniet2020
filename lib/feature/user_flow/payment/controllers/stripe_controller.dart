import 'dart:convert';
import 'package:anniet2020/core/network/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/offline_storage/shared_pref.dart';
import '../views/pages/stripe_webview.dart';

class StripeController extends GetxController {
  // These were missing — that's why you got "Undefined name" errors
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // Open Stripe setup in WebView
  void openStripeWebView(String url) {
    Get.to(() => StripeWebView(stripeUrl: url));
  }

  Future<void> openStripeCheckout(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch Stripe Checkout';
    }
  }



  Future<void> setupStripeAccount() async {
    try {
      isLoading.value = true;
      EasyLoading.show(status: 'Generating secure link...');

      final token = await SharedPreferencesHelper.getToken();
      if (token == null) {
        errorMessage.value = "No access token found. Please log in again.";
        EasyLoading.showError("Please log in again");
        return;
      }

      final headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        Uri.parse('${ApiEndpoints.baseUrl}/payment/create-checkout-session'),
        headers: headers,
      );

      print('Request: ${response.request?.url}');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final stripeUrl = data['data']['url'] as String;

        EasyLoading.showSuccess("Opening secure setup...");
        await Future.delayed(const Duration(milliseconds: 800));

        // Open in-app WebView
        // openStripeWebView(stripeUrl);
        await openStripeCheckout(stripeUrl);

      } else {
        final msg = json.decode(response.body)['message'] ?? 'Failed to generate link';
        EasyLoading.showError(msg);
      }
    } catch (e) {
      print("Stripe Error: $e");
      EasyLoading.showError("Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }
}