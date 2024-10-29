import 'dart:math';

import 'package:eats_application/data/data_base.dart';
import 'package:eats_application/models/cooking_model.dart';
import 'package:eats_application/widgets/cooking_card.dart';
import 'package:eats_application/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class CookScreen extends StatefulWidget {
  CookScreen({super.key, required this.cooking});
  Cooking cooking;
  @override
  State<CookScreen> createState() => _CookScreenState();
}

class _CookScreenState extends State<CookScreen> {
  List<Map<String, dynamic>> data = DataBase.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: myAppBar(),
      body: CookingCard(
        onButton: false,
        onTap: () {},
        cooking: widget.cooking,
      ),
    );
  }
}
