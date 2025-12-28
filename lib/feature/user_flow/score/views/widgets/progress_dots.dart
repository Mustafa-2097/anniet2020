import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class ProgressDots extends StatelessWidget {
  final int total;
  final int completedVideos;
  const ProgressDots({super.key, required this.total, required this.completedVideos});

  @override
  Widget build(BuildContext context) {
    final safeCompleted = completedVideos.clamp(0, total);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total * 2 - 1, (i) {
          /// Circle position
          if (i.isEven) {
            int index = i ~/ 2;
            final bool isCompleted = index < safeCompleted;

            return Container(
              height: 30.r,
              width: 30.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.primaryColor : Colors.transparent,
                border: Border.all(
                  color: isCompleted ? AppColors.primaryColor : const Color(0xFFE9E9E9),
                ),
              ),
              child: Text(
                "${index + 1}",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  color: isCompleted ? AppColors.whiteColor : AppColors.subTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          /// Line between circles
          int lineIndex = (i - 1) ~/ 2;
          final bool isLineCompleted = lineIndex < safeCompleted - 1;
          return Container(
            height: 1.5.h,
            width: 20.w,
            color: isLineCompleted ? AppColors.primaryColor : const Color(0xFFE9E9E9),
          );
        },
      ),
    );
  }
}
