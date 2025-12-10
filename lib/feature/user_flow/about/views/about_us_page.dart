import 'package:anniet2020/core/constant/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: const BackButton(color: Colors.black),
        ),
        title: Text("About us", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Section Card
            Row(
              children: [
                // Avatar Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Image.asset(ImagePath.about01, height: 130.h, width: 118.w, fit: BoxFit.cover),
                ),
                SizedBox(width: 14),

                // Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Annie Trainor",
                        style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                      ),
                      Text(
                        "Founder",
                        style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, color: AppColors.primaryColor, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Hi my name is Annie Trainor and l am the Director of Drink Drive Victoria.",
                        style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Colors.grey.shade700, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 6),

                      // LinkedIn Button
                      Text(
                        "Connect With",
                        style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(ImagePath.linkedIn, width: 24.w, fit: BoxFit.contain),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // About Description
            Text(
              "www.drinkdrivevictoria.com.au I have been a Drug "
                  "and Alcohol Facilitator for over 3 years working mainly "
                  "with remote Cleveland and have lived here for the past "
                  "year.",
              style: GoogleFonts.plusJakartaSans(fontSize: 14, height: 1.6, color: Colors.grey.shade800),
            ),

            SizedBox(height: 12),

            Text(
              "My experience is the overwhelming response from our participants "
                  "that once they have secured what a great session it is and that "
                  "they never knew how much the new Roadsafe / Policing and Legal "
                  "apply and would not know this.",
              style: GoogleFonts.plusJakartaSans(fontSize: 14, height: 1.6, color: Colors.grey.shade800),
            ),

            SizedBox(height: 12),

            Text(
              "My hope is that by sharing these experiences along with "
                  "the information provided and including high impact video "
                  "imagery about their choices and actions becomes more of "
                  "an impact that YOU don't blow YOUR licenses/your future "
                  "results and don't harm kill yourself or someone else.",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                height: 1.6,
                color: Colors.grey.shade800,
              ),
            ),

            SizedBox(height: 20),

            /// Join Now Section
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "So what are you waiting for?... Don't Blow Your License!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: StadiumBorder(),
                      padding:
                      EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: Text(
                      "Join Now",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 25),

            /// Recent Blog Section Title
            Align(
              alignment: Alignment.center,
              child: Text(
                "Recent Blog",
                style: GoogleFonts.plusJakartaSans(fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
              ),
            ),

            SizedBox(height: 12),

            // Blog Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(ImagePath.about02, height: 160.h,width: double.infinity, fit: BoxFit.cover),
            ),

            SizedBox(height: 20.h),

            // Blog Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Text(
                "40 Impaired Drivers Caught in One Weekend! 🚓",
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),

            SizedBox(height: 8),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Employers, The Effects More Than You Think! Over the weekend, "
                    "Victoria Police caught 40 drink and drug drivers in a major sweep.",
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(fontSize: 14, height: 1.6, color: Colors.grey.shade800),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
