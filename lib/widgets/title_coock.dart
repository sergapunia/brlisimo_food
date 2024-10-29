import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/cooking_model.dart';
import '../screens/cook_screen.dart';

class CookingTitleCard extends StatelessWidget {
  CookingTitleCard({super.key, required this.cooking});
  Cooking cooking;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CookScreen(cooking: cooking),
          ),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Text(
                  cooking.name,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 80.h,
                    child: Image.network(
                      cooking.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 2,
                        children: cooking.ingredients
                            .map((item) => Text(
                                  "•$item",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
