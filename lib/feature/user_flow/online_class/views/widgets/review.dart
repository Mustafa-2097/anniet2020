import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../controllers/review_controller.dart';
import '../../models/review_model.dart';

class Review extends StatelessWidget {
  Review({super.key});
  final controller = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
            ),
          ],
        ),

        SizedBox(height: 20.h),

        /// Reviews List
        Obx(() {
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.reviews.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final review = controller.reviews[index];
              return ReviewItem(review: review);
            },
          );
        }),
      ],
    );
  }
}

class ReviewItem extends StatelessWidget {
  final ReviewModel review;
  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Rating + Date + More Icon
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 18),
            SizedBox(width: 4.h),
            Text(
              review.rating.toString(),
              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 4.h),
            Text(
              review.date,
              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Icon(Icons.more_horiz, color: Colors.black87),
          ],
        ),

        SizedBox(height: 10.h),

        /// Review Text
        Text(
          review.review,
          style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600),
        ),

        SizedBox(height: 10.h),

        /// Username
        Text(
          review.userName,
          style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
