import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/image_path.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(color: Colors.black),
        title: Text("Recent Blog", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          children: [
            /// The FULL GREY SCROLL TRACK
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 6.w,
                height: double.infinity,
                color: AppColors.greyColor,
              ),
            ),

            RawScrollbar(
              controller: scrollController,
              thumbColor: AppColors.primaryColor,
              radius: Radius.circular(8.r),
              thickness: 6.w,
              minThumbLength: 134.h,
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    // Blog Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(ImagePath.about02, height: 160.h,width: double.infinity, fit: BoxFit.cover),
                    ),

                    SizedBox(height: 16.h),

                    // Blog Title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "40 Impaired Drivers Caught in One Weekend! 👮",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Text(
                      "Employers, The Effects More Than You Think!",
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    Text(
                      "Over the weekend, Victoria Police caught 40 drink and drug drivers in a major freeway blitz. It’s an important operation that keeps our roads safer — but the ripple effects go far beyond the headlines.",
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      "What Getting Caught Really Means for a Driver 🚚🚖🛵🚙🛻🚛",
                      style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    Text(
                      "For the individual behind the wheel, the consequences are life-changing:\n\n"
                        "1. Loss of licence and independence\n"
                        "2. Heavy fines\n"
                        "3. Behaviour Change Programs\n"
                        "4. Interlocks\n"
                          "5. Court appearances\n"
                        "6. Risk of losing their job\n"
                        "7. Pressure on relationships\n"
                        "8. Serious impacts on mental health and self-esteem\n\n"
                        "As confronting as this is, there is one silver lining — getting caught may have stopped them from harming themselves or someone else.",
                      style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                    ),

                    SizedBox(height: 20.h),

                    Text(
                      "But Employers… Here’s the Part That’s Often Overlooked",
                      style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    Text(
                      "If your business relies on staff who drive — whether full-time drivers or employees who drive as part of their role — one impaired-driving incident can disrupt your entire operation.",
                      style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                    ),
                    Text(
                      "Here’s what it can mean for you:🚫 Sudden loss of a key worker🔄 Schedules thrown into chaos📦 Delivery timelines blown out📉 Impact on KPIs and customer commitments💰 Increased overtime and staffing costs😓 Added pressure on remaining drivers💥 Risk to your brand and reputation "
                        "And on a human level, it’s tough. We all make mistakes — but the consequences of this particular mistake can be devastating for both the worker and the business.",
                      style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "The Good News: You Can Reduce Your Risk✅",
                      style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    Text(
                      "Proactive education is one of the most effective ways to prevent impaired-driving incidents in your workforce.",
                      style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                    ),
                    Text(
                      "Don’t Blow Your Licence delivers engaging, evidence-based training designed specifically to:\n",
                      style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                    ),
                    Text(
                      "1. Strengthen driver decision-making\n"
                          "2. Build awareness of risk\n"
                          "3. Reduce workplace disruptions\n"
                          "4. Protect your staff, your business, and your reputation\n",
                      style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.boxTextColor),
                    ),
                    Text(
                      "It’s easier (and far cheaper) to prevent a drink/drug-driving incident than to deal with one.",
                      style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                    ),


                    SizedBox(height: 20.h),
                    Text(
                      "Employers: Now is the time to act👍",
                      style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    Text(
                      "Reach out today to book your drivers or your entire workforce into Don’t Blow Your Licence. Keep your team safe. Keep your business running smoothly. And keep your brand protected.",
                      style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, fontWeight: FontWeight.w400, color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 30.h),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
