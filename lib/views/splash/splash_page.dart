import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utills/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(
        seconds: 3,
      ),
      () => Get.offNamed(GetPages.home),
    );
    return Scaffold(
      body: Center(
        child: Container(
          height: 300.h,
          width: 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/images/notes.avif'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
