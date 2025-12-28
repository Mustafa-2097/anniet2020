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
      debugPrint("❌ getNextVideo error: $e");
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
      _applyLockFromBackend();
    } catch (e) {
      debugPrint("fetchLessons error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> completeIntroAndRefresh() async {
    /// 1️⃣ backend কে বলো next video generate করতে
    await _repository.getNextVideo(courseId);

    /// 2️⃣ backend থেকে fresh lesson list আনো
    await fetchLessons();
  }


  /// Core lock/unlock logic
  void _applyLockFromBackend() {
    bool nextUnlockedGiven = false;
    for (final lesson in lessons) {
      /// No video → always locked
      if (lesson.video == null || lesson.video!.isEmpty) {
        lesson.isLocked = true;
        continue;
      }
      /// Intro always unlocked
      if (lesson.order == 1) {
        lesson.isLocked = false;
        continue;
      }
      /// Completed lessons unlocked
      if (lesson.isCompleted) {
        lesson.isLocked = false;
        continue;
      }
      /// First incomplete lesson unlocked
      if (!nextUnlockedGiven) {
        lesson.isLocked = false;
        nextUnlockedGiven = true;
      } else {
        lesson.isLocked = true;
      }
    }
    lessons.refresh();
  }

  /// Call this when exam passed or intro completed
  Future<void> refreshFromBackend() async {
    await fetchLessons();
  }

}
