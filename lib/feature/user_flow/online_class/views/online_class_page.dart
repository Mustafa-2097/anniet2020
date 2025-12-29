import 'package:anniet2020/feature/user_flow/Exam/views/exam_page.dart';
import 'package:anniet2020/feature/user_flow/lessons/views/lessons_page.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/widgets/before_continue.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/widgets/review.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/widgets/video_detail_card.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../lessons/controllers/lessons_controller.dart';
import '../../lessons/models/lesson_model.dart';
import '../controllers/online_class_controller.dart';

class OnlineClassPage extends StatefulWidget {
  final String courseId;
  final LessonModel lesson;
  const OnlineClassPage({super.key, required this.courseId, required this.lesson});
  @override
  State<OnlineClassPage> createState() => _OnlineClassPageState();
}

class _OnlineClassPageState extends State<OnlineClassPage> {
  late OnlineClassController controller;
  late LessonModel _currentLesson;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _currentLesson = widget.lesson;
    controller = Get.put(OnlineClassController(), tag: widget.lesson.id);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setVideo(_currentLesson.video);
    });
  }

  @override
  void dispose() {
    Get.delete<OnlineClassController>(tag: widget.lesson.id);
    super.dispose();
  }

  Future<void> _handleContinue() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);
    EasyLoading.show(status: "Please wait...");

    final lessonsController = Get.find<LessonsController>(tag: widget.courseId);

    try {
      // STEP 1: CHECK IF LESSON HAS EXAM (using questionsCount from model)
      if (_currentLesson.hasExam) {
        EasyLoading.show(status: "Loading exam...");
        await Future.delayed(Duration(milliseconds: 1000));
        EasyLoading.dismiss();
        setState(() => _isProcessing = false);
        Get.off(() => ExamPage(
          courseId: widget.courseId,
          lessonId: _currentLesson.id,
          isLessonAlreadyCompleted: _currentLesson.isCompleted,
        ));
        return;
      }

      // STEP 2: COMPLETE LESSON ONLY IF NOT COMPLETED BEFORE
      if (!_currentLesson.isCompleted) {
        EasyLoading.show(status: "Completing lesson...");
        await lessonsController.getNextVideo(widget.courseId);
        await lessonsController.refreshFromBackend();
        EasyLoading.showSuccess("Lesson Completed!");
        await Future.delayed(Duration(milliseconds: 500));
      }

      // STEP 3: FIND NEXT LESSON
      EasyLoading.show(status: "Finding next lesson...");
      await Future.delayed(Duration(milliseconds: 2000));
      final lessons = lessonsController.lessons;
      final currentIndex = lessons.indexWhere((l) => l.id == _currentLesson.id);

      LessonModel? nextLesson;
      if (currentIndex != -1 && currentIndex + 1 < lessons.length) {
        nextLesson = lessons[currentIndex + 1];
      }

      // STEP 4: NAVIGATE OR UPDATE VIDEO
      if (nextLesson != null && nextLesson.video != null && nextLesson.video!.isNotEmpty && !nextLesson.isLocked) {
        // Update in-place
        setState(() {
          _currentLesson = nextLesson!;
        });

        // Delete old controller & initialize new video
        Get.delete<OnlineClassController>(tag: _currentLesson.id);
        controller = Get.put(OnlineClassController(), tag: _currentLesson.id);
        controller.setVideo(_currentLesson.video);

        await Future.delayed(Duration(milliseconds: 500));
        EasyLoading.dismiss();
        setState(() => _isProcessing = false);
        return;
      }

      // STEP 5: COURSE END
      EasyLoading.showSuccess("Course completed!");
      // Show success message before navigation
      await Future.delayed(Duration(milliseconds: 1000));
      EasyLoading.dismiss();
      setState(() => _isProcessing = false);
      Get.off(() => LessonsPage(courseId: widget.courseId));
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong", backgroundColor: AppColors.redColor);
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.r),
        children: [
          // VIDEO
          Container(
            height: sh * 0.226,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
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

          // DETAILS
          VideoDetailsCard(
            title: _currentLesson.title,
            lessonNum: _currentLesson.order.toString(),
            description: _currentLesson.description,
            infoMessage: "Before watching the next video, please watch this one attentively and answer the questions.",
          ),
          SizedBox(height: 24.h),
          BeforeYouContinueCard(questionCount: _currentLesson.questionsCount),
          SizedBox(height: 16.h),

          // CONTINUE BUTTON
          ElevatedButton(
            onPressed: _isProcessing ? null : _handleContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
            child: Text(
              "Continue",
              style: GoogleFonts.notoSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          SizedBox(height: 20.h),

          // REVIEW
          Review(lessonId: _currentLesson.id),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
