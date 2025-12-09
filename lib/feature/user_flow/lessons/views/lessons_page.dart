import 'package:anniet2020/feature/user_flow/lessons/views/widgets/lesson_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import '../models/lesson_model.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      LessonModel(
        title: "1. What do we really think about Drink and Drug Driving?",
        duration: "2 hours",
        isCompleted: true,
        image: ImagePath.lesson01,
        isLocked: false,
      ),
      LessonModel(
        title: "1. How Long do Alcohol and Drugs stay in your Body?",
        duration: "2 hours",
        isCompleted: false,
        image: ImagePath.lesson02,
        isLocked: true,
      ),
      LessonModel(
        title: "1. The Law, Penalties and Personal Consequences",
        duration: "2 hours",
        isCompleted: false,
        image: ImagePath.lesson03,
        isLocked: true,
      ),
      LessonModel(
        title: "1. Planning Ahead",
        duration: "2 hours",
        isCompleted: false,
        image: ImagePath.lesson04,
        isLocked: true,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: const BackButton(color: Colors.black),
        ),
        title: Text("06 Lessons", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.r),
            child: Icon(Icons.more_vert, color: Colors.black),
          )
        ],
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(20.r),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return LessonTile(lesson: lessons[index]);
        },
      ),
    );
  }
}
