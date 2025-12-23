import 'package:anniet2020/feature/user_flow/review/views/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../review/controllers/review_page_controller.dart';
import '../../../review/views/widgets/give_review.dart';
import '../../../review/views/widgets/review_item.dart';

class Review extends StatelessWidget {
  final String lessonId;
  const Review({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewUserController(lessonId), tag: lessonId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Review",
              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600),
            ),
            // Write a review button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              icon: Icon(Icons.add, color: AppColors.whiteColor),
              label: Text(
                "Write a Review",
                style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  builder: (_) => GiveReview(lessonId: lessonId,),
                );
              },
            ),
          ],
        ),

        SizedBox(height: 20.h),

        /// Reviews List
        Obx(() {
          /// 1 - Show loader while fetching
          if (controller.isLoading.value) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                ),
              ),
            );
          }

          /// 2 - Empty state
          if (controller.reviews.isEmpty) {
            return Center(
              child: Text(
                "No reviews yet",
                style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.boxTextColor),
              ),
            );
          }

          /// 3 - Show max 2 reviews
          final limitedReviews = controller.reviews.take(2).toList();
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: limitedReviews.length,
            separatorBuilder: (_, __) => SizedBox(height: 20.h),
            itemBuilder: (context, index) {
              return ReviewItem(review: limitedReviews[index]);
            },
          );
        }),

        SizedBox(height: 10.h),

        /// See more button
        Obx(() {
          final reviewsCount = controller.reviews.length;
          /// Show button ONLY if more than 2 reviews
          if (reviewsCount <= 2) return const SizedBox(); // Hide button

          return Center(
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => Get.off(() => ReviewUserPage(lessonId: lessonId)),
              child: Text(
                "See more reviews",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.redColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.redColor,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
