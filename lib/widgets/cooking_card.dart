import 'dart:developer' as dev;
import 'dart:math';

import 'package:eats_application/models/cooking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CookingCard extends StatelessWidget {
  CookingCard(
      {super.key,
      required this.cooking,
      required this.onTap,
      required this.onButton});

  Cooking cooking;
  VoidCallback onTap;
  bool onButton;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        titleImage(cooking.image, 300, null),
        name(),
        if (onButton) buttonReload(),
        ingredients(),
        if (cooking.description != null) description(),
        cook(),
      ],
    );
  }

  Widget titleImage(String link, double h, double? w) {
    return Container(
      child: Image.network(
        height: h.h,
        width: w?.w ?? double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return const Divider();
        },
        link,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadProgress) {
          if (loadProgress == null)
            return Container(
              child: child,
              height: h.h,
              width: w?.w ?? double.infinity,
            );
          return Container(
            height: h.h,
            width: w?.w ?? double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                value: loadProgress.expectedTotalBytes != null
                    ? loadProgress.cumulativeBytesLoaded /
                        loadProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget name() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(
              thickness: 2.h,
            ),
            Text(
              cooking.name,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            Divider(
              thickness: 2.h,
              indent: 50.w,
              endIndent: 50.w,
            ),
          ],
        ));
  }

  Widget description() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Text(
        cooking.description!,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget ingredients() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ингредиенты",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 15.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cooking.ingredients
                .map(
                  (item) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    child: Text("• $item",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500)),
                  ),
                )
                .toList(),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget cook() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          children: [
            const Divider(),
            Center(
              child: Text(
                "Рецепт",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: generListCook()
                  .map((List<String> item) => Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Text(
                              item[0],
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w400),
                            ),
                          ),
                          titleImage(item[1], 200, 300),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ));
  }

  List<List<String>> generListCook() {
    List<List<String>> result = [];
    int len1 = cooking.instructions.length;
    int len2 = cooking.imageInstructions.length;

    for (int i = 0; i < max(len1, len2); i += 1) {
      List<String> pre = [];
      i < len1 ? pre.add("${i + 1}: ${cooking.instructions[i]}") : pre.add("");
      i < len2 ? pre.add(cooking.imageInstructions[i]) : pre.add("");
      result.add(pre);
    }
    return result;
  }

  Widget buttonReload() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.r),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Другое блюдо",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            Icon(Icons.replay_outlined, size: 25.r)
          ],
        ),
      ),
    );
  }
}
