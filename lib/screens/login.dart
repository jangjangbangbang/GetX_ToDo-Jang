import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/controllers/authController.dart';

import 'signup.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "Email"),
                controller: emailController,
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: "Password"),
                controller: passwordController,
              ),
              RaisedButton(
                  child: Text("Log In"),
                  onPressed: () {
                    controller.login(
                        emailController.text, passwordController.text);
                  }),
              FlatButton(
                  onPressed: () {
                    Get.to(SignUp());
                  },
                  child: Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }
}
