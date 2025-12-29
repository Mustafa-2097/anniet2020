import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constant/app_colors.dart';

class VideoDetailsCard extends StatelessWidget {
  final String title, lessonNum, description, infoMessage;
  const VideoDetailsCard({super.key, required this.title, required this.lessonNum, required this.description, required this.infoMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE + RATING ROW
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
          ),

          SizedBox(height: 3.h),

          /// DESCRIPTION TEXT
          Text(
            "Lesson: $lessonNum",
            style: GoogleFonts.plusJakartaSans(fontSize: 11.sp, color: AppColors.subTextColor, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: 6.h),

          /// DESCRIPTION TEXT
          Text(
            description,
            style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.subTextColor, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: 8.h),

          /// INFO BOX
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Colors.blue, size: 22.r),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    infoMessage,
                    style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.blackColor, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
