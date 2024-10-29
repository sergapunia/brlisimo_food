import 'dart:math';
import 'dart:developer' as dev;
import 'package:eats_application/data/data_base.dart';
import 'package:eats_application/models/cooking_model.dart';
import 'package:eats_application/widgets/cooking_card.dart';
import 'package:eats_application/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class RandomScreenCook extends StatefulWidget {
  RandomScreenCook({super.key});

  @override
  State<RandomScreenCook> createState() => _RandomScreenCookState();
}

class _RandomScreenCookState extends State<RandomScreenCook> {
  List<Map<String, dynamic>> data = DataBase.data;

  @override
  Widget build(BuildContext context) {
    final randMap = data[Random().nextInt(data.length)];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: myAppBar(),
      body: CookingCard(
        onButton: true,
        onTap: () {
          setState(() {});
        },
        cooking: Cooking.fromJson(
          randMap,
        ),
      ),
    );
  }
}
