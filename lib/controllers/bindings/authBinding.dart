import 'package:get/get.dart';
import 'package:getx_todo/controllers/authController.dart';

import '../todoController.dart';
import '../userController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => TodoController());
  }
}
