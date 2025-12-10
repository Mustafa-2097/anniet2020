import 'package:anniet2020/feature/user_flow/payment/views/pages/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../auth/sign_up/views/widgets/success_dialog.dart';

class AddNewCardController extends GetxController {
  static AddNewCardController get instance => Get.find();

  /// Controllers
  final cardNumberController = TextEditingController();
  final cardHolderNameController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  /// Validation: Card Number
  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) return "Card number required";
    if (value.length < 16) return "Card number must be 16 digits";
    return null;
  }

  /// Validation: Card Holder Name
  String? validateHolderName(String? value) {
    if (value == null || value.isEmpty) return "Card holder name required";
    if (value.length < 3) return "Name too short";
    return null;
  }

  /// Validation: Expiry Date
  String? validateExpiry(String? value) {
    if (value == null || value.isEmpty) return "Expiry date required";
    if (!RegExp(r"^(0[1-9]|1[0-2])\/\d{2}$").hasMatch(value)) {
      return "Invalid format (MM/YY)";
    }
    return null;
  }

  /// Validation: CVV
  String? validateCVV(String? value) {
    if (value == null || value.isEmpty) return "CVV required";
    if (value.length != 3) return "CVV must be 3 digits";
    return null;
  }

  /// Save Card
  Future<void> saveCard(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    EasyLoading.show(status: 'Saving Card...');
    await Future.delayed(const Duration(seconds: 2));
    EasyLoading.dismiss();

    /// Show Success Dialog
    SuccessDialog.show(
      subtitle: "Your card has been added successfully!",
      onContinue: () {
        Get.back(); // dialog close
        Get.to(() => PaymentMethod()); // go back to previous page
      },
    );
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.onClose();
  }
}
