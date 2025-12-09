import 'package:anniet2020/feature/user_flow/review/views/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../review/controllers/review_page_controller.dart';
import '../../../review/views/widgets/review_item.dart';

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
          /// Reviews list from controller
          final reviews = controller.reviews;

          /// Empty state handle
          if (reviews.isEmpty) {
            return Center(
              child: Text(
                "No reviews yet",
                style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.boxTextColor),
              ),
            );
          }

          /// Only take maximum 2 reviews safely
          final limitedReviews = reviews.take(2).toList();

          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: limitedReviews.length,
            separatorBuilder: (_, __) => SizedBox(height: 20.h),
            itemBuilder: (context, index) {
              return ReviewItem(review: limitedReviews[index]);
            },
          );
        }),

        SizedBox(height: 10.h),

        /// See more button
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => Get.to(()=> ReviewPage()),
            child: Text(
              "See more reviews",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.redColor,
                decoration: TextDecoration.underline, decorationColor: AppColors.redColor,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
