import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/model/auth/user_model.dart';

class UserController extends GetxController {
  final user = User().obs;
  var user1 = Rxn<User>();

  void clearUser() {
    user1.value = null;
  }
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
