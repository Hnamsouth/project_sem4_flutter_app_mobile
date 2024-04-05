import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/model/user_model.dart';

class UserController extends GetxController {
  final user = User().obs;
  setUser(User setUser) {
    user.update((val) {
      val?.id = setUser.id;
      val?.username = setUser.username;
      val?.authResponse = setUser.authResponse;
      val?.roles = setUser.roles;
      val?.permissions = setUser.permissions;
      val?.userDetail = setUser.userDetail;
    });
  }
}
