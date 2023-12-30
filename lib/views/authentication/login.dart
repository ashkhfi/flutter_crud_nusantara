import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../home/home.dart';
import 'register.dart';

class Login extends StatelessWidget {
  final AuthController _authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Welcome Back",
                  style:
                      TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.w),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.deepPurpleAccent.withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.w),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.deepPurpleAccent.withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.password),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    await _authController
                        .loginUser({"email": email, "password": password});
                    if (_authController.isAuthenticated.value == true) {
                      Get.off(() => Home());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Belum punya akun? "),
                TextButton(
                  onPressed: () {
                    Get.to(() => Register());
                  },
                  child: const Text(
                    "Daftar",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
