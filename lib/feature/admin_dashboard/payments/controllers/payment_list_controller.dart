import 'package:get/get.dart';

class PaymentListController extends GetxController {
  static PaymentListController get instance => Get.find();
  final currentPage = 1.obs;
  final totalPages = 5;

  final users = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUsersForPage(1);
  }

  /// Page change
  void goPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      loadUsersForPage(currentPage.value);
    }
  }

  void goNextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
      loadUsersForPage(currentPage.value);
    }
  }

  void goToPage(int page) {
    currentPage.value = page;
    loadUsersForPage(page);
  }

  /// Load new data for each page
  void loadUsersForPage(int page) {
    users.value = List.generate(10, (index) {
      return {
        "name": "User $page-$index",
        "id": "${page}00$index",
        "email": "user${page}_$index@gmail.com",
        "Payment Date": "$page/$index",
        "Transaction ID": "TXN${page}00$index",
      };
    });
  }
}
