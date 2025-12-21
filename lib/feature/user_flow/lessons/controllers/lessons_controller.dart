import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../../data/repositories/user_repository.dart';
import '../models/lesson_model.dart';

class LessonsController extends GetxController {
  final UserRepository _repository = UserRepository();
  final String courseId;
  LessonsController(this.courseId);

  var isLoading = true.obs;
  var lessons = <LessonModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchLessons();
  }

  Future<void> fetchLessons() async {
    try {
      isLoading(true);
      final fetchedLessons = await _repository.getLessons(courseId);
      debugPrint("Fetched lessons: ${fetchedLessons.length}");
      /// Sort by order (important)
      fetchedLessons.sort((a, b) => a.order.compareTo(b.order));
      lessons.value = fetchedLessons;
      _applyLockingLogic();
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: AppColors.redColor);
    } finally {
      isLoading(false);
    }
  }

  /// Core lock/unlock logic
  void _applyLockingLogic() {
    for (int i = 0; i < lessons.length; i++) {
      final lesson = lessons[i];
      /// If no video → always locked
      if (lesson.video == null || lesson.video!.isEmpty) {
        lesson.isLocked = true;
        continue;
      }

      /// First lesson always unlocked
      if (i == 0) {
        lesson.isLocked = false;
        continue;
      }

      /// Unlock only if previous lesson completed
      lesson.isLocked = !lessons[i - 1].isCompleted;
    }
    lessons.refresh();
  }

  /// Call this after exam pass
  void markLessonCompleted(String lessonId) {
    final index = lessons.indexWhere((l) => l.id == lessonId);
    if (index == -1) return;
    lessons[index].isCompleted = true;

    /// Unlock next lesson safely
    if (index + 1 < lessons.length) {
      final nextLesson = lessons[index + 1];

      /// Only unlock if video exists
      if (nextLesson.video != null && nextLesson.video!.isNotEmpty) {
        nextLesson.isLocked = false;
      }
    }
    lessons.refresh();
  }

  Future<void> syncNextVideoFromServer() async {
    try {
      final nextLesson = await _repository.getNextVideo(courseId);
      if (nextLesson == null) return;

      final index = lessons.indexWhere((l) => l.id == nextLesson.id);
      if (index != -1) {
        lessons[index].isLocked = false;
        lessons.refresh();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: AppColors.redColor);
    }
  }

}

