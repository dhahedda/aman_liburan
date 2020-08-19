import 'package:get/state_manager.dart';

class UserController extends GetxController {
  var photoUrl;
  updateProfile(String _photoUrl) {
    photoUrl = _photoUrl;
    update();
  }
}
