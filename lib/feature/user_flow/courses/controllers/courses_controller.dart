import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../../data/repositories/user_repository.dart';
import '../models/course_model.dart';

class CoursesController extends GetxController {
  static CoursesController get instance => Get.find();
  final UserRepository _repository = UserRepository();

  var isLoading = true.obs;
  var courses = <Course>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      isLoading(true);
      courses.value = await _repository.getCourses();
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: AppColors.redColor);
    } finally {
      isLoading(false);
    }
  }
}
