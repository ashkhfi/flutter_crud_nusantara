import 'package:flutter/material.dart';
import 'package:flutter_crud_nusantara/controllers/book_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';

import 'views/authentication/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => BookController());
    return ScreenUtilInit(
      designSize: const Size(376, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
          debugShowCheckedModeBanner: false,
          home: Login(),
        );
      },
    );
  }
}
