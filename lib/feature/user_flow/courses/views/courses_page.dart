import 'package:anniet2020/core/constant/widgets/primary_button.dart';
import 'package:anniet2020/feature/user_flow/courses/views/widgets/course_card.dart';
import 'package:anniet2020/feature/user_flow/lessons/views/lessons_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: Text("Your Courses", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.r),
            child: Icon(Icons.more_vert),
          )
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// BLUE INFO CONTAINER
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.r),
            color: AppColors.primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Learn the Rules.",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Learn the key mistakes that can cause your driving license to be cancelled.",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          SizedBox(height: 30.h),

          /// COURSE CARD
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CourseCard(
              title: "Don't Blow Your Licence",
              lessons: "03/06 Lessons",
              progress: 0.40,
              image: ImagePath.coursesBg,
            ),
          ),

          SizedBox(height: 30.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PrimaryButton(
              text: "Continue",
              onPressed: () => Get.to(() => LessonsPage()),
            ),
          )
        ],
      ),
    );
  }
}
