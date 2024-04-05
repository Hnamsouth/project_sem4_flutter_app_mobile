import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:project_sem4_flutter_app_mobile/service/user_service.dart';

class AuthGuard extends StatefulWidget {
  const AuthGuard({super.key});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  final UserController userController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _checkUser() async {
    if (userController.user.value.id != null) {
      var getUser = await UserService.loginToken();
      if (getUser) {
        // userController.user.value.roles?.map((e) => e.name.contains(other))
        // Get.offNamed('/')
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
