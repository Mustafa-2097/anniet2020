import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../settings/controllers/settings_controller.dart';

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
    final settings = SettingsController.instance;

    // Update Settings page data
    settings.updateProfile(
      name: fullName.value,
      phoneNumber: phone.value,
      emailAddress: email.value,
      imagePath: pickedImage.value?.path,
    );

    print("Profile saved & sent back to SettingsPage!");

    Get.back(); // return to SettingsPage
  }
}
