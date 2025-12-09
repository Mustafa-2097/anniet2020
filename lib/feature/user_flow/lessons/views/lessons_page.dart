import 'package:anniet2020/feature/user_flow/lessons/views/widgets/LessonTile.dart';
import 'package:flutter/material.dart';
import '../models/lesson_model.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      LessonModel(
        title: "What do we really think about Drink and Drug Driving?",
        duration: "2 hours",
        isCompleted: true,
        image: "assets/lesson1.png",
      ),
      LessonModel(
        title: "How Long do Alcohol and Drugs stay in your Body?",
        duration: "2 hours",
        isCompleted: true,
        image: "assets/lesson2.png",
      ),
      LessonModel(
        title: "The Law, Penalties and Personal Consequences",
        duration: "2 hours",
        isCompleted: true,
        image: "assets/lesson3.png",
      ),
      LessonModel(
        title: "Planning Ahead",
        duration: "2 hours",
        isCompleted: false,
        image: "assets/lesson4.png",
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "06 Lessons",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.more_vert, color: Colors.black),
          )
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return LessonTile(lesson: lessons[index]);
        },
      ),
    );
  }
}
