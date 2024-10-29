import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar myAppBar() {
  return AppBar(
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belissimo cooking",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 5,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        Image.asset(
          "assets/icons/icon.png",
          width: 30.w,
        )
      ],
    ),
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.black,
  );
}
