import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class BeforeYouContinueCard extends StatelessWidget {
  const BeforeYouContinueCard({super.key});

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
    final bullets = [
      "You must answer 5 MCQ questions after this video.",
      "You need at least 80% score to unlock the next video.",
      "You can retry the quiz if you fail.",
      "Your progress will be saved automatically.",
      "You can’t skip questions — all must be answered to continue.",
    ];

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
