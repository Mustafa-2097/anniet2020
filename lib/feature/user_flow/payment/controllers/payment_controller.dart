import 'dart:convert';
import 'package:anniet2020/core/network/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../core/offline_storage/shared_pref.dart';
import '../model/payment_model.dart';

class PaymentPageController extends GetxController {

  var isLoading = false.obs;
  var paymentPageData = Rxn<PaymentUserData>();
  var errorMessage = ''.obs;
  var isError = false.obs;


  /// Fetch payment page data
  Future<void> fetchPaymentPage() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}/payment/page'),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final paymentResponse =
        PaymentPageResponse.fromJson(jsonResponse);

        paymentPageData.value = paymentResponse.data;
      } else {
        errorMessage.value =
        'Failed to load data (${response.statusCode})';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _setError(String msg) {
    isError.value = true;
    errorMessage.value = msg;
  }

}

