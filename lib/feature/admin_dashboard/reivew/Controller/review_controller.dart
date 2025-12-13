import 'package:get/get.dart';
import '../models/review_model.dart';

class ReviewAdminController extends GetxController {
  /// Summary
  final double averageRating = 4.4;
  final int totalReviews = 7;

  /// star : count
  final Map<int, int> ratings = {
    5: 4,
    4: 2,
    3: 1,
    2: 0,
    1: 0,
  };

  /// 0 = All, 5,4,3,2,1
  final RxInt selectedFilter = 0.obs;

  /// Reviews list
  final RxList<ReviewAdminModel> reviews = <ReviewAdminModel>[
    ReviewAdminModel(
      name: "Sarah Johnson",
      avatar: "https://i.pravatar.cc/150?img=1",
      rating: 5,
      time: "2 days ago",
      lesson: "Lessons 01",
      comment:
      "This course was absolutely amazing! The instructor explained complex concepts in a very clear and understandable way. The hands-on projects really helped solidify my learning.",
    ),
    ReviewAdminModel(
      name: "Michael Chen",
      avatar: "https://i.pravatar.cc/150?img=8",
      rating: 4,
      time: "5 days ago",
      lesson: "Lessons 02",
      comment:
      "Great course overall! Very comprehensive content. Would love to see more real-world examples though.",
    ),
    ReviewAdminModel(
      name: "Sarah Johnson",
      avatar: "https://i.pravatar.cc/150?img=1",
      rating: 5,
      time: "2 days ago",
      lesson: "Lessons 01",
      comment:
      "This course was absolutely amazing! The instructor explained complex concepts in a very clear and understandable way. The hands-on projects really helped solidify my learning.",
    ),
  ].obs;

  /// Rating progress
  double getProgress(int star) {
    if (totalReviews == 0) return 0;
    return (ratings[star] ?? 0) / totalReviews;
  }

  /// Count for filter chips
  int getCount(int star) {
    if (star == 0) return totalReviews;
    return ratings[star] ?? 0;
  }

  /// Filtered review list
  List<ReviewAdminModel> get filteredReviews {
    if (selectedFilter.value == 0) return reviews;
    return reviews.where((e) => e.rating == selectedFilter.value).toList();
  }
}
