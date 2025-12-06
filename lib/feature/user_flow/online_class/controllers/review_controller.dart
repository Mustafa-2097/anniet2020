import 'package:get/get.dart';
import '../models/review_model.dart';

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();
  var reviews = <ReviewModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadReviews();
  }

  void loadReviews() {
    reviews.value = [
      ReviewModel(
        rating: 4.4,
        date: "27/06/2022",
        review:
        "Lorem ipsum dolor sit amet,  adipiscing elit. Sed at gravida nulla tempor, neque. Duis quam ut netus donec enim vitae ac diam.",
        userName: "Carter Botosh",
      ),
      ReviewModel(
        rating: 4.2,
        date: "23/06/2022",
        review:
        "Lorem ipsum dolor sit amet,  adipiscing elit. Sed at gravida nulla tempor, neque. Duis quam ut netus donec enim vitae ac diam.",
        userName: "Jaxson Septimus",
      ),
    ];
  }

  void addReview(ReviewModel review) {
    reviews.insert(0, review);
  }
}
