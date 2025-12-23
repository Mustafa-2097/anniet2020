import 'package:anniet2020/core/constant/image_path.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/online_class_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../models/lesson_model.dart';

class LessonTile extends StatelessWidget {
  final LessonModel lesson;
  final String courseId;
  const LessonTile({super.key, required this.lesson, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (lesson.isLocked) {
          Get.snackbar("Locked", "Complete previous lesson first", backgroundColor: AppColors.redColor);
          return;
        }
        Get.to(() => OnlineClassPage(lessonId: lesson.id, courseId: courseId));
      },

      child: Container(
        margin: EdgeInsets.only(bottom: 12.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Color(0xFF9CA4AB), width: 1.3.w),
        ),
        child: Row(
          children: [
            /// IMAGE with lock unlock
            Stack(
              children: [
                /// IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(ImagePath.lesson01, height: 75.h, width: 75.w, fit: BoxFit.cover),
                ),

                /// ICON OVER IMAGE
                Positioned.fill(
                  child: Center(
                    child: Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        lesson.isLocked ? Icons.lock : Icons.play_arrow,
                        color: Colors.white,
                        size: 20.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 12.w),

            /// TEXTS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 20.r, color: AppColors.primaryColor),
                      SizedBox(width: 6.w),
                      Text(
                        lesson.duration,
                        style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w400, color:  AppColors.boxTextColor),
                      ),
                      const Spacer(),
                      Text(
                        lesson.isCompleted ? "Completed" : "",
                        style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color:  AppColors.primaryColor),
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
                  if (lesson.order != 1)
                    LinearProgressIndicator(
                      value: lesson.isCompleted ? 1.0 : 0.0,
                      minHeight: 6,
                      backgroundColor: Colors.grey,
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.greenColor,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
