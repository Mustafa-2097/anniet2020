import 'package:anniet2020/feature/user_flow/Exam/views/exam_page.dart';
import 'package:anniet2020/feature/user_flow/lessons/views/lessons_page.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/widgets/before_continue.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/widgets/review.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/widgets/video_detail_card.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/primary_button.dart';
import '../../lessons/models/lesson_model.dart';
import '../controllers/online_class_controller.dart';

class OnlineClassPage extends StatelessWidget {
  final String courseId;
  final LessonModel lesson;
  OnlineClassPage({super.key, required this.courseId, required this.lesson});
  final controller = Get.put(OnlineClassController());

  @override
  Widget build(BuildContext context) {
    controller.setVideo(lesson.video);
    final sh = MediaQuery.of(context).size.height;
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
              Get.delete<OnlineClassController>();
              Get.to(() => LessonsPage(courseId: courseId));
            },
          ),
        ),
        title: Text("Online Class", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.r),
        children: [
          /// Video Thumbnail / Player placeholder
          Container(
            height: sh * 0.23,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Obx(() {
                if (!controller.isInitialized.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return Chewie(
                  controller: controller.chewieController!,
                );
              }),
            ),
          ),

          SizedBox(height: 20.h),

          /// Video Details Card
          VideoDetailsCard(
            title: lesson.title,
            description: lesson.description,
            infoMessage: "Before watching the next video, please watch this one attentively and answer the questions.",
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

          SizedBox(height: 25.h),
          /// Continue Button
          PrimaryButton(text: "Continue", onPressed: () => Get.to(() => ExamPage(courseId: courseId, lesson: lesson))),
        ],
      ),
    );
  }
}
