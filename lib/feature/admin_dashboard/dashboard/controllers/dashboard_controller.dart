import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();
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
    /// Just 3 for dashboard if user available else No users
    users.value = [
      {
        "name": "Wilson Levin",
        "id": "100$page",
        "email": "user${page}a@gmail.com",
        "cert": "Received",
        "course": "Complete",
        "payment": "Paid",
      },
      {
        "name": "Wilson Levin",
        "id": "200$page",
        "email": "user${page}b@gmail.com",
        "cert": "Not Received",
        "course": "Pending",
        "payment": "Unpaid",
      },
      {
        "name": "User $page A",
        "id": "100$page",
        "email": "user${page}a@gmail.com",
        "cert": "Received",
        "course": "Complete",
        "payment": "Paid",
      },
    ];
  }
}
