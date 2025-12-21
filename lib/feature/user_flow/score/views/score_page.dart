import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:anniet2020/feature/user_flow/score/views/widgets/progress_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import '../../lessons/controllers/lessons_controller.dart';
import '../models/score_model.dart';

class ScorePage extends StatelessWidget {
  final ScoreData result;
  final VoidCallback onNext;
  final String courseId;
  ScorePage({super.key, required this.result, required this.onNext, required this.courseId});
  final ProfileController profile = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final lessons = Get.find<LessonsController>(tag: courseId);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 110.h),

              /// Result Icon
              Image.asset(
                result.isPassed ? ImagePath.congratsIcon : ImagePath.failIcon,
                width: 185.w,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 20.h),

              /// Score Text
              Text(
                "Your Score : ${result.score.toString().padLeft(2, '0')} out of ${result.total.toString().padLeft(2, '0')}",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: result.isPassed ? AppColors.primaryColor : AppColors.redColor,
                ),
              ),

              SizedBox(height: 6.h),

              /// Subtitle
              Text(
                result.isPassed
                    ? "Great job, ${profile.userName}! You did it"
                    : "Keep practicing. Retry to review the lesson first, then attempt the exam again.",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.blackColor),
              ),

              SizedBox(height: 30.h),

              /// Progress Dots
              ProgressDots(
                total: lessons.lessons.length,
                completedVideos: result.completedVideos,
              ),

              const Spacer(),

              /// Bottom Button
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      result.isPassed ? "Next" : "Re-try",
                      style: GoogleFonts.notoSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
