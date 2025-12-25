import 'package:anniet2020/core/constant/widgets/primary_button.dart';
import 'package:anniet2020/feature/user_flow/courses/views/widgets/course_card.dart';
import 'package:anniet2020/feature/user_flow/lessons/views/lessons_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import '../controllers/courses_controller.dart';

class CoursesPage extends StatelessWidget {
  CoursesPage({super.key});
  final controller = Get.put(CoursesController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          title: Text("Your Courses", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchCourses();
          },
          child: Obx(() {

            // if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
            if (controller.courses.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const Center(
                    child: Text("You're not Subscribed"),
                  ),
                ),
              );
            }


            final course = controller.courses.first;
            final total = course.totalLessons;
            final completed = course.completedLessons.clamp(0, total);
            final progress = total == 0 ? 0.0 : completed / total;

            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// BLUE INFO CONTAINER
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.r)),
                    ),
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
                      title: course.title,
                      lessons:  "$completed/$total Lessons",
                      progress: progress,
                      image: ImagePath.coursesBg,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: PrimaryButton(
                      text: "Continue",
                      onPressed: () {
                                final course = controller.courses.first;
                                Get.to(() => LessonsPage(courseId: course.id));
                              }
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
