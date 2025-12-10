import 'package:get/get.dart';

class HelpSupportController extends GetxController {
  static HelpSupportController get instance => Get.find();

  var isLoading = false.obs;
  void toggle() => isLoading.value = !isLoading.value;

  /// -1 means all collapsed
  var expandedIndex = (-1).obs;

  /// FAQ List
  final List<Map<String, String>> faqList = [
    {
      "title": "Lorem ipsum dolor sit amet",
      "content":
      "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."
    },
    {
      "title": "Lorem ipsum dolor sit amet",
      "content":
      "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint."
    },
    {
      "title": "Lorem ipsum dolor sit amet",
      "content":
      "Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."
    },
    {
      "title": "Lorem ipsum dolor sit amet",
      "content":
      "Consequat sunt nostrud amet exercitation veniam velit mollit."
    },
  ];

  /// Toggle expanded item
  void toggleExpand(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // collapse
    } else {
      expandedIndex.value = index; // expand new item
    }
  }
}
