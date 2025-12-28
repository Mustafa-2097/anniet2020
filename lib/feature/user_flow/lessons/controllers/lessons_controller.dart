import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/user_repository.dart';
import '../models/lesson_model.dart';

class LessonsController extends GetxController {
  final UserRepository _repository = UserRepository();
  final String courseId;
  LessonsController(this.courseId);

  final isLoading = true.obs;
  final lessons = <LessonModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLessons();
  }

  Future<void> getNextVideo(String courseId) async {
    try {
      await _repository.getNextVideo(courseId);
    } catch (e) {
      debugPrint("getNextVideo error: $e");
    }
  }

  /// Fetch lessons from backend (single source of truth)
  Future<void> fetchLessons() async {
    try {
      isLoading(true);
      final fetchedLessons = await _repository.getLessons(courseId);
      /// Safety sort
      fetchedLessons.sort((a, b) => a.order.compareTo(b.order));
      lessons.value = fetchedLessons;
      /// Apply lock logic ONLY from backend state
      applyLockFromBackend();
    } catch (e) {
      debugPrint("fetchLessons error: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Core lock/unlock logic
  void applyLockFromBackend() {
    bool unlockNext = true;

    for (final lesson in lessons) {
      if (lesson.video == null || lesson.video!.isEmpty) {
        lesson.isLocked = true;
        continue;
      }

      if (lesson.isCompleted) {
        lesson.isLocked = false;
        continue;
      }

      if (unlockNext) {
        lesson.isLocked = false;
        unlockNext = false;
      } else {
        lesson.isLocked = true;
      }
    }

    lessons.refresh();
  }

  /// Call this when exam passed or no question is found
  Future<void> refreshFromBackend() async {
    await fetchLessons();
  }

}
