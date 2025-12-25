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
import '../../data/repositories/user_repository.dart';
import '../../lessons/controllers/lessons_controller.dart';
import '../../lessons/models/lesson_model.dart';
import '../controllers/online_class_controller.dart';

class OnlineClassPage extends StatefulWidget {
  final String courseId;
  final String lessonId;

  const OnlineClassPage({super.key, required this.courseId, required this.lessonId});

  @override
  State<OnlineClassPage> createState() => _OnlineClassPageState();
}

class _OnlineClassPageState extends State<OnlineClassPage> {
  late final OnlineClassController controller;

  /// ALWAYS read lesson from controller (single source of truth)
  LessonModel get lesson => Get.find<LessonsController>(tag: widget.courseId)
          .lessons
          .firstWhere((l) => l.id == widget.lessonId);

  @override
  void initState() {
    super.initState();
    controller = Get.put(OnlineClassController());

    controller.setVideo(
      lesson.video,
      // onCompleted: () async {
      //   if (lesson.order == 1) {
      //     final lessonsController = Get.find<LessonsController>(tag: widget.courseId);
      //     await lessonsController.completeIntroAndRefresh();
      //   }
      // },

    );
  }

  @override
  void dispose() {
    Get.delete<OnlineClassController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isIntroLesson = lesson.order == 1;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () {
            Get.off(() => LessonsPage(courseId: widget.courseId));
          },
        ),
        title: Text(
          "Online Class",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.r),
        children: [
          /// ================= VIDEO =================
          Container(
            height: sh * 0.23,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Obx(() {
                if (!controller.isInitialized.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return Chewie(controller: controller.chewieController!);
              }),
            ),
          ),

          SizedBox(height: 20.h),

          /// ================= DETAILS =================
          VideoDetailsCard(
            title: lesson.title,
            description: lesson.description,
            infoMessage:
            "Before watching the next video, please watch this one attentively and answer the questions.",
          ),

            SizedBox(height: 20.h),
            BeforeYouContinueCard(),
            SizedBox(height: 20.h),
            Review(lessonId: lesson.id),
            SizedBox(height: 25.h),

            /// ================= CONTINUE =================
            ElevatedButton(
              onPressed: () async {
                final repository = UserRepository();
                final lessonsController =
                Get.find<LessonsController>(tag: widget.courseId);

                /// STEP 1: check exam
                final bool hasQuestions =
                await repository.hasExamQuestions(lesson.id);

                if (hasQuestions) {
                  Get.off(() => ExamPage(
                    courseId: widget.courseId,
                    lessonId: lesson.id,
                  ));
                  return;
                }

                /// STEP 2: unlock next lesson ONLY ONCE
                if (!lesson.isCompleted) {
                  await lessonsController.getNextVideo(widget.courseId);
                  await lessonsController.fetchLessons();
                }

                /// STEP 3: navigate safely
                final lessons = lessonsController.lessons;
                final currentIndex =
                lessons.indexWhere((l) => l.id == lesson.id);

                if (currentIndex != -1 &&
                    currentIndex + 1 < lessons.length) {
                  final nextLesson = lessons[currentIndex + 1];

                  if (!nextLesson.isLocked) {
                    Get.off(() => OnlineClassPage(
                      courseId: widget.courseId,
                      lessonId: nextLesson.id,
                    ));
                    return;
                  }
                }

                /// STEP 4: fallback
                Get.off(() => LessonsPage(courseId: widget.courseId));
              },


              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Text(
                "Continue",
                style: GoogleFonts.notoSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

