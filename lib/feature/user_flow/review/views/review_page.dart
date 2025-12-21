import 'package:anniet2020/feature/user_flow/review/controllers/review_page_controller.dart';
import 'package:anniet2020/feature/user_flow/review/views/widgets/give_review.dart';
import 'package:anniet2020/feature/user_flow/review/views/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';

class ReviewUserPage extends StatelessWidget {
  final String lessonId;
  const ReviewUserPage({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewUserController(lessonId), tag: lessonId);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: const BackButton(color: Colors.black),
        ),
        title: Text("Review", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.r, 16.r, 16.r, 0.r),
            child: Column(
              children: [
                /// Rating Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.r),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _ratingSummary(controller),
                      ),
                      Expanded(
                        flex: 2,
                        child: _ratingBreakdown(controller),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                /// Review List Scrollable
                Expanded(child: _reviewList(lessonId)),
              ],
            ),
          ),

          /// Bottom Button
          Positioned(
            bottom: 18.h,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
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
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 16.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    backgroundColor: AppColors.primaryColor
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: AppColors.whiteColor, size: 18.r),
                    SizedBox(width: 6.w),
                    Text(
                      "Write a Review",
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color:  AppColors.whiteColor),
                    ),
                  ]
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _ratingSummary(ReviewUserController controller) {
    return Obx( () =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.averageRating.toStringAsFixed(1),
            style: GoogleFonts.plusJakartaSans(fontSize: 32.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4.h),
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < controller.averageRating.round()
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amber,
                size: 18.r,
              );
            }),
          ),
          SizedBox(height: 8.h),
          Text(
            "Based on ${controller.reviews.length} reviews",
            style: GoogleFonts.plusJakartaSans(fontSize: 10.sp, fontWeight: FontWeight.w600, color: AppColors.subTextColor),
          ),
        ],
      ),
    );
  }

  Widget _ratingBreakdown(ReviewUserController controller) {
    return Obx( () =>
      Column(
        children: List.generate(5, (i) {
          final star = 5 - i;
          final count = controller.counts[star] ?? 0;
          final total = controller.reviews.isEmpty
              ? 1
              : controller.reviews.length;
          return Padding(
            padding: EdgeInsets.only(bottom: 6.r),
            child: Row(
              children: [
                Text("$star"),
                SizedBox(width: 8.w),
                Expanded(
                  child: LinearProgressIndicator(
                    value: count / total,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _reviewList(String lessonId) {
    final controller = Get.find<ReviewUserController>(tag: lessonId);
    return Obx(() {
      return ListView.separated(
        itemCount: controller.reviews.length,
        separatorBuilder: (_, __) => SizedBox(height: 20.h),
        itemBuilder: (_, index) {
          final review = controller.reviews[index];
          return ReviewItem(review: review);
        },
      );
    });
  }

}
