import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import 'login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final AuthController _authController = Get.find();

  Register({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: ScreenUtil().screenHeight - 50.h,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 60.h),
                  Text(
                    "Register ",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Buat akun Anda",
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.deepPurpleAccent.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.deepPurpleAccent.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.deepPurpleAccent.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _passwordConfirmController,
                    decoration: InputDecoration(
                      hintText: "Konfirmasi Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.deepPurpleAccent.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3.h, left: 3.w),
                child: ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String name = _nameController.text;
                    String passwordConfirm = _passwordConfirmController.text;
                    String password = _passwordController.text;

                    await _authController.registerUser({
                      "name": name,
                      "email": email,
                      "password": password,
                      "password_confirmation": passwordConfirm,
                    });
                    _emailController.clear();
                    _nameController.clear();
                    _passwordController.clear();
                    _passwordConfirmController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Sudah punya akun?"),
                  TextButton(
                    onPressed: () {
                      _emailController.clear();
                      _nameController.clear();
                      _passwordController.clear();
                      _passwordConfirmController.clear();
                      Get.to(() => Login());
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
