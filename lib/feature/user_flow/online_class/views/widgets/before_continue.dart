import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class BeforeYouContinueCard extends StatelessWidget {
  final bool hasExam;
  final int questionCount;
  const BeforeYouContinueCard({super.key, required this.hasExam, required this.questionCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title Row with star icon
        Row(
          children: [
            Text(
              "⭐ Before You Continue",
              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
            ),
          ],
        ),
        const SizedBox(height: 16),

        /// Content list
        ..._buildBulletPoints(),
      ],
    );
  }

  List<Widget> _buildBulletPoints() {
    final bullets = hasExam ? [
      "You must answer $questionCount MCQ questions after this video.",
      "You need 100% score to unlock the next video.",
      "You can rewatch the video and retry the quiz again if you fail.",
      "Your progress will be saved automatically.",
      "You can’t skip questions — all must be answered to continue.",
    ] :  [
      "Watch the full video to continue.",
      "Make sure you understand the concepts.",
      "Your progress will be saved automatically.",
      "You can continue to the next lesson when ready.",
    ] ;

    return List.generate(bullets.length, (index) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${index + 1}.  ",
              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.subTextColor),
            ),
            Expanded(
              child: Text(
                bullets[index],
                style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.subTextColor),
              ),
            ),
          ],
        ),
      );
    });
  }
}
