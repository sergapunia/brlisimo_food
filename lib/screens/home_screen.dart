import 'dart:developer';

import 'package:eats_application/screens/ingredients_to_search.dart';
import 'package:eats_application/screens/random%3Ecook_screen.dart';
import 'package:eats_application/screens/serch_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/my_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: myAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset("assets/food_image.jpg"),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Чтож, Давай тебя накормим!",
                          style: TextStyle(
                              fontSize: 22.sp, fontWeight: FontWeight.w400)),
                      Text("выбери удобный способ найти рецепты",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
                cardVariable("Случайный рецепт", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RandomScreenCook(),
                    ),
                  );
                }),
                cardVariable("Поиск рецептов", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SerchProductsScreen(),
                    ),
                  );
                }),
                cardVariable("Поиск по ингредиентам", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IngredientsToSearch(),
                    ),
                  );
                }),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async {
                const url = 'https://t.me/sergapunia';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  log('Could not launch $url');
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r),
                    )),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Ваш покорный слуга: ",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w300)),
                    Text("@sergapunia",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cardVariable(String text, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.black),
        ),
        child: Text(text,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
