import 'package:get/get.dart';
import '../models/review_page_model.dart';

class ReviewUserController extends GetxController {
  static ReviewUserController get instance => Get.find();

  /// Review list
  final RxList<ReviewUserModel> reviews = <ReviewUserModel>[].obs;

  /// Pagination state
  final isLoading = false.obs;
  final hasMore = true.obs;
  int page = 1;

  /// Rating stats
  final ratingStats = <int, double>{
    5: 0.45,
    4: 0.30,
    3: 0.15,
    2: 0.07,
    1: 0.03,
  }.obs;

  /// Toggle this flag to test empty state
  final bool isTestEmpty = false; /// change to false to test pagination

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  /// Safe fake paginated API
  Future<void> fetchReviews() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    /// Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    /// EMPTY STATE TEST
    if (isTestEmpty && page == 1) {
      reviews.clear();
      hasMore.value = false; /// very important
      isLoading.value = false;
      return;
    }

    /// PAGINATION TEST DATA (8 per page)
    final newData = List.generate(
      4, (index) => ReviewUserModel(
        rating: 4.0 + (index % 2) * 0.2,
        date: "23/06/2022",
        comment: "Lorem ipsum dolor sit amet, adipiscing elit. Sed at gravida nulla tempor, neque.Lorem ipsum dolor sit amet,  adipiscing elit. Sed at gravida nulla tempor, neque. Duis quam ut netus donec enim vitae ac diam.",
        userName: "User ${index + 1 + (page - 1) * 8}",
      ),
    );

    /// Stop pagination after 4 pages
    if (page >= 4) {
      hasMore.value = false;
    }

    reviews.addAll(newData);
    page++;
    isLoading.value = false;
  }
}
