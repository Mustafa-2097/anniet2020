import 'package:get/get.dart';

class OnlineClassController extends GetxController {
  var title = "".obs;
  var rating = 0.0.obs;
  var description = "".obs;
  var infoMessage = "".obs;

  @override
  void onInit() {
    loadDetails();
    super.onInit();
  }

  /// Mock API call
  void loadDetails() {
    title.value = "Introduction";
    rating.value = 4.8;
    description.value =
    "An introduction and overview of the Don't Blow Your Licence info online program.";
    infoMessage.value =
    "Before watching the next video, please watch this one attentively and answer the questions.";
  }
}
