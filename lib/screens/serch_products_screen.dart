import 'package:eats_application/data/data_base.dart';
import 'package:eats_application/models/cooking_model.dart';
import 'package:eats_application/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/title_coock.dart';

class SerchProductsScreen extends StatefulWidget {
  const SerchProductsScreen({super.key});

  @override
  State<SerchProductsScreen> createState() => _SerchProductsScreenState();
}

class _SerchProductsScreenState extends State<SerchProductsScreen> {
  List<Map<String, dynamic>> filteredData = [];

  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> data = DataBase.data;
  @override
  void initState() {
    super.initState();
    filteredData = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _filterData(value);
              },
              decoration:  InputDecoration(
                hintText: 'Search...',
                border: const OutlineInputBorder(),
                suffixIcon: Icon(Icons.search,size:20.r),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                return CookingTitleCard(cooking: Cooking.fromJson(item));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _filterData(String query) {
    setState(() {
      filteredData = data.where((item) {
        final name = item['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }
}
