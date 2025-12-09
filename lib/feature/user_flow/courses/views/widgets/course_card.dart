import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String lessons;
  final double progress;
  final String image;

  const CourseCard({super.key, required this.title, required this.lessons, required this.progress, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(image), /// IMAGE Bg
          fit: BoxFit.cover,
        )
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(color: AppColors.whiteColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 4.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lessons,
                  style: GoogleFonts.plusJakartaSans(color: AppColors.greyColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: GoogleFonts.plusJakartaSans(color: AppColors.greenColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),

            SizedBox(height: 6.h),

            /// PROGRESS BAR
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.greenColor,
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }
}