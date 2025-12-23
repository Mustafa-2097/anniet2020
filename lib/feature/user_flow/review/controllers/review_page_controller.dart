import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../../data/repositories/user_repository.dart';
import '../models/review_page_model.dart';

class ReviewUserController extends GetxController {
  static ReviewUserController get instance => Get.find();
  final String lessonId;
  ReviewUserController(this.lessonId);
  final _repo = UserRepository();
  final RxList<ReviewUserModel> reviews = <ReviewUserModel>[].obs;
  final isLoading = false.obs;

  double averageRating = 0;
  final RxMap<int, int> counts = <int, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      isLoading.value = true;
      final data = await _repo.getLessonReviews(lessonId);
      reviews.value = (data['reviews'] as List)
          .map((e) => ReviewUserModel.fromJson(e))
          .toList();
      averageRating = (data['average'] as num).toDouble();
      final rawCounts = Map<String, dynamic>.from(data['counts']);
      counts.value = rawCounts.map(
            (key, value) => MapEntry(int.parse(key), value as int),
      );
    } finally {
      isLoading.value = false;
    }
  }

  final isSubmitting = false.obs;

  Future<void> submitReview({
    required int rating,
    required String comment,
  }) async {
    print("Submitting review for lesson: $lessonId");
    try {
      isSubmitting.value = true;
      await _repo.createReview(
        lessonId: lessonId,
        rating: rating,
        comment: comment,
      );
      await fetchReviews(); // refresh list
      Get.back();
      // close bottom sheet
      Get.snackbar("Success", "Review submitted successfully", backgroundColor: AppColors.primaryColor);
    } catch (e) {
      debugPrint("REVIEW SUBMIT ERROR: $e");
      Get.snackbar("Error", e.toString(), backgroundColor: AppColors.redColor);
    } finally {
      isSubmitting.value = false;
    }
  }
}
