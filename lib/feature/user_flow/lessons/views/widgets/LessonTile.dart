import 'package:flutter/material.dart';
import '../../models/lesson_model.dart';

class LessonTile extends StatelessWidget {
  final LessonModel lesson;

  const LessonTile({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              lesson.image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          /// TEXTS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  lesson.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text(
                      lesson.duration,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      lesson.isCompleted ? "Completed" : "",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 8),

                LinearProgressIndicator(
                  value: lesson.isCompleted ? 1.0 : 0.0,
                  minHeight: 6,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blue,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
