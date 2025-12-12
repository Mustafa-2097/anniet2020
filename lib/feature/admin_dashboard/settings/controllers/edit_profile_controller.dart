import 'package:get/get.dart';

class EditProfileController extends GetxController {
  static EditProfileController get instance => Get.find();

  var fullName = "John Anderson".obs;
  var email = "admin@dashboard.com".obs;
  var phone = "+1 (555) 123-4567".obs;

  var pickedImage = Rx<XFile?>(null);

  final ImagePicker picker = ImagePicker();

  Future pickImage() async {
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      pickedImage.value = img;
    }
  }

  void saveProfile() {
    // Save API call here
    print("Saving profile...");
    print("Name: ${fullName.value}");
    print("Email: ${email.value}");
    print("Phone: ${phone.value}");
    Get.back();
  }
}
