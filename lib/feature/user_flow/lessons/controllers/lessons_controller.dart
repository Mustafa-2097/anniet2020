import 'package:get/get.dart';
import '../../data/repositories/user_repository.dart';
import '../models/lesson_model.dart';

class LessonsController extends GetxController {
  static LessonsController get instance => Get.find();
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
      lessons.value = await _repository.getLessons(courseId);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
