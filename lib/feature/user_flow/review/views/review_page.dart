import 'package:anniet2020/feature/user_flow/review/controllers/review_page_controller.dart';
import 'package:anniet2020/feature/user_flow/review/views/widgets/give_review.dart';
import 'package:anniet2020/feature/user_flow/review/views/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({super.key});
  final controller = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
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
                        child: _ratingSummary(),
                      ),
                      Expanded(
                        flex: 2,
                        child: _ratingBreakdown(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                /// Review List Scrollable
                Expanded(child: _reviewList(),),
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
                    builder: (_) => GiveReview(),
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

  Widget _ratingSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "4.4",
          style: GoogleFonts.plusJakartaSans(fontSize: 32.sp, fontWeight: FontWeight.w700, color: AppColors.blackColor),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 18.r),
            Icon(Icons.star, color: Colors.amber, size: 18.r),
            Icon(Icons.star, color: Colors.amber, size: 18.r),
            Icon(Icons.star, color: Colors.amber, size: 18.r),
            Icon(Icons.star, color: AppColors.greyColor, size: 18.r),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          "Based on 532 review",
          style: GoogleFonts.plusJakartaSans(fontSize: 10.sp, fontWeight: FontWeight.w600, color: AppColors.subTextColor),
        ),
      ],
    );
  }

  Widget _ratingBreakdown() {
    final controller = Get.find<ReviewController>();
    return Column(
      children: controller.ratingStats.entries.map((e) {
        return Padding(
          padding: EdgeInsets.only(bottom: 5.r),
          child: Row(
            children: [
              Text(e.key.toString(), style: GoogleFonts.plusJakartaSans(fontSize: 10.sp, fontWeight: FontWeight.w600, color: AppColors.subTextColor)),
              SizedBox(width: 12.w),
              Expanded(
                child: LinearProgressIndicator(
                  value: e.value,
                  minHeight: 6,
                  backgroundColor: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.greenColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _reviewList() {
    final controller = Get.find<ReviewController>();

    return Obx(() {
      return ListView.separated(
        itemCount: controller.reviews.length + 1,
        separatorBuilder: (_, __) => SizedBox(height: 20.h),
        itemBuilder: (context, index) {
          /// Bottom loader for pagination
          if (index == controller.reviews.length) {
            if (controller.hasMore.value) {
              controller.fetchReviews();
              return Padding(
                padding: EdgeInsets.all(60.r),
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return const SizedBox();
            }
          }

          final review = controller.reviews[index];
          return ReviewItem(review: review);
        },
      );
    });
  }

}
