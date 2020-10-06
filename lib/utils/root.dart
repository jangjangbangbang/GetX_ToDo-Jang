import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getx_todo/controllers/authController.dart';
import 'package:getx_todo/controllers/userController.dart';
import 'package:getx_todo/screens/home.dart';
import 'package:getx_todo/screens/login.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
