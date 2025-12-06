import 'package:anniet2020/feature/user_flow/online_class/views/widgets/before_continue.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/widgets/review.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/widgets/video_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/primary_button.dart';

class OnlineClassPage extends StatelessWidget {
  const OnlineClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: ListView(
            children: [
              /// Video Playing
              Image.asset("assets/images/video_playing.png", height: sh * 0.23, width: double.infinity, fit: BoxFit.cover),

              SizedBox(height: 20.h),

              /// Video Details Card
              VideoDetailsCard(
                title: "Introduction",
                rating: 4.8,
                description:
                "An introduction and overview of the Don't Blow Your Licence info online program.",
                infoMessage:
                "Before watching the next video, please watch this one attentively and answer the questions.",
              ),

              SizedBox(height: 20.h),

              /// Text
              Text(
                "What we really think about Drink and Drug Driving and how it impairs our ability to Drive Safely?",
                style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 20.h),

              ///
              BeforeYouContinueCard(),

              SizedBox(height: 20.h),

              ///
              Review(),

              SizedBox(height: 20.h),
              /// Continue Button
              PrimaryButton(text: "Continue", onPressed: () {}),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
