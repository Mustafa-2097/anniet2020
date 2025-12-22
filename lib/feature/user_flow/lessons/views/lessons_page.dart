import 'package:anniet2020/feature/user_flow/dashboard/customer_dashboard.dart';
import 'package:anniet2020/feature/user_flow/lessons/views/widgets/lesson_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../controllers/lessons_controller.dart';

class LessonsPage extends StatelessWidget {
  final String courseId;
  const LessonsPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    Get.put(LessonsController(courseId), tag: courseId);
    final controller = Get.find<LessonsController>(tag: courseId);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.blackColor, size: 24.r),
            onPressed: () {
              Get.delete<LessonsController>(tag: courseId);
              Get.to(() => CustomerDashboard(initialIndex: 1));
            },
          ),
        ),
        title: Obx(() => Text("${controller.lessons.length} Lessons", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor))),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.all(20.r),
          itemCount: controller.lessons.length,
          itemBuilder: (_, index) {
            return LessonTile(lesson: controller.lessons[index], courseId: courseId);
          },
        );
      }),
    );
  }
}
