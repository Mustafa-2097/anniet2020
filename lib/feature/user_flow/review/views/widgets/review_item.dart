import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../models/review_page_model.dart';

class ReviewItem extends StatelessWidget {
  final ReviewUserModel review;
  const ReviewItem({super.key, required this.review});
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Rating + Date + More Icon
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 14.r),
            SizedBox(width: 4.w),
            Text(
              review.rating.toString(),
              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 4.w),
            Text(
              formatDate(review.createdAt),
              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.boxTextColor, fontWeight: FontWeight.w600),
            ),
          ],
        ),

        SizedBox(height: 10.h),

        /// Review Text
        Text(
          review.comment,
          style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, color: AppColors.blackColor, fontWeight: FontWeight.w400),
        ),

        SizedBox(height: 8.h),

        /// Username
        Text(
          review.userName,
          style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.boxTextColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}