import 'package:anniet2020/core/constant/app_colors.dart';
import 'package:anniet2020/core/constant/image_path.dart';
import 'package:anniet2020/feature/user_flow/Exam/views/widgets/color_button.dart';
import 'package:anniet2020/feature/user_flow/online_class/views/online_class_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../lessons/controllers/lessons_controller.dart';
import '../controllers/exam_controller.dart';

class ExamPage extends StatelessWidget {
  final String courseId;
  final String lessonId;
  const ExamPage({super.key, required this.courseId, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExamController(lessonId: lessonId, courseId: courseId));
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      extendBody: true,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                /// =================== TOP BAR ===================
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        final lessonsController = Get.find<LessonsController>(tag: courseId);
                        final lesson = lessonsController.lessons.firstWhere((l) => l.id == lessonId);
                        Get.off(() => OnlineClassPage(courseId: courseId, lesson: lesson));
                      },
                      icon: Icon(Icons.arrow_back_ios, size: 16.r, color: AppColors.blackColor),
                    ),
                    SizedBox(width: 18.w),
                    SizedBox(
                      height: 12.h,
                      width: 186.w,
                      child: LinearProgressIndicator(
                        value: controller.progress,
                        backgroundColor: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.greenColor,
                      ),
                    ),
                    SizedBox(width: 18.w),
                    Image.asset(ImagePath.progressIcon, width: 24, fit: BoxFit.contain),
                    SizedBox(width: 5.w),
                    /// Current question progress text (1/5, 2/5, 3/5...)
                    Text(
                      "${controller.currentIndex.value + 1}/${controller.totalQuestions}",
                      style: GoogleFonts.notoSans(fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),

                /// ================= QUESTION =================
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ================= QUESTION =================
                        Text(
                          controller.question.question,
                          style: GoogleFonts.notoSans(fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                          softWrap: true,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Tap the correct answer",
                          style: GoogleFonts.notoSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor),
                        ),
                        SizedBox(height: 12.h),

                        /// ================= OPTIONS =================
                        ...List.generate(
                          controller.question.options.length,
                              (index) {
                            return _OptionTile(
                              index: index,
                              text: controller.question.options[index],
                            );
                          },
                        ),

                        /// bottom safe spacing so last option isn't hidden
                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ),


                //const Spacer(),

                /// =================== BOTTOM ACTION ===================
                if (!controller.isAnswered.value)
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: ColorButton(
                      text: "Check",
                      onPressed: controller.checkAnswer,
                      isEnabled: controller.selectedIndex.value != -1,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.isAnswered.value && controller.isCorrect.value) {
          return _CorrectBottomSheet(onContinue: controller.nextQuestion);
        }
        if (controller.isAnswered.value && !controller.isCorrect.value) {
          return _WrongBottomSheet(onContinue: controller.nextQuestion);
        }
        return const SizedBox.shrink();
      }),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final int index;
  final String text;
  const _OptionTile({required this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExamController>();

    return Obx(() {
      Color bg = AppColors.greyColor;

      if (controller.isAnswered.value) {
        if (index == controller.question.correctIndex) {
          bg = AppColors.greenColor;
        } else if (index == controller.selectedIndex.value &&
            controller.selectedIndex.value != controller.question.correctIndex) {
          bg = Color(0xFFCCDEED);
        }
      } else if (index == controller.selectedIndex.value) {
        bg = Color(0xFFCCDEED);
      }

      return GestureDetector(
        onTap: controller.isAnswered.value
            ? null
            : () => controller.selectOption(index),
        child: Container(
          width: double.infinity,
          margin:EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(text, style: GoogleFonts.notoSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color:  AppColors.blackColor)),
        ),
      );
    });

  }
}

class _CorrectBottomSheet extends StatelessWidget {
  final VoidCallback onContinue;
  const _CorrectBottomSheet({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      color: const Color(0xFFDAF3E0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Check Icon + Correct text
          Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF478400), size: 28.r),
              SizedBox(width: 8.w),
              Text("Correct!", style: GoogleFonts.notoSans(fontSize: 16.sp,fontWeight: FontWeight.w700, color: Color(0xFF478400))),
            ],
          ),
          SizedBox(height: 20.h),
          /// Continue button
          ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50.h),
              backgroundColor: Color(0xFF5ACD05),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            /// Continue to Score Page
            child: Text(
              "Continue",
              style: GoogleFonts.notoSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color:  AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _WrongBottomSheet extends StatelessWidget {
  final VoidCallback onContinue;
  const _WrongBottomSheet({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExamController>();
    final sh = MediaQuery.of(context).size.height;

    return Container(
      height: sh * 0.25,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      color: Color(0xFFFEE0DF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          Row(
            children: [
              Icon(Icons.cancel, color: AppColors.redColor, size: 28.r),
              SizedBox(width: 8.w),
              Text("Incorrect", style: GoogleFonts.notoSans(fontSize: 16.sp,fontWeight: FontWeight.w700, color: AppColors.redColor)),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            "Correct Answer: ${controller.question.options[controller.question.correctIndex]}",
            style: GoogleFonts.notoSans(fontSize: 14.sp,fontWeight: FontWeight.w700, color: AppColors.greenColor),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
                backgroundColor: AppColors.redColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Text(
                "Got it",
                style: GoogleFonts.notoSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color:  AppColors.whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
