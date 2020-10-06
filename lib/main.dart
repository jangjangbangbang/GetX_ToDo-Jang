import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/controllers/bindings/authBinding.dart';
import 'package:firebase_core/firebase_core.dart';

import 'utils/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      home: Root(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
