import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/data_base.dart';
import '../models/cooking_model.dart';
import '../widgets/my_appbar.dart';
import '../widgets/title_coock.dart';

class IngredientsToSearch extends StatefulWidget {
  const IngredientsToSearch({super.key});

  @override
  State<IngredientsToSearch> createState() => _IngredientsToSearchState();
}

class _IngredientsToSearchState extends State<IngredientsToSearch> {
  List<Map<String, dynamic>> filteredData = [];

  List<String> ingredientsSearch = [];

  List<TextEditingController> controllers = [];
  List<InputWidget> inputs = [];

  List<Map<String, dynamic>> data = DataBase.data;

  @override
  void initState() {
    super.initState();
    addNewInput();
    //filteredData = data;
  }

  // void _filterData(String query) {
  //   setState(() {
  //     filteredData = data.where((item) {
  //       final name = item['ingredients'].toString().toLowerCase();
  //       return name.contains(query.toLowerCase());
  //     }).toList();
  //   });
  // }

  void performSearch() {
    final searchTerms = controllers.map((c) => c.text.toLowerCase()).toList();
    if (searchTerms.every((term) => term.isEmpty)) {
      // Если все поисковые запросы пусты, очищаем filteredData
      filteredData = [];
    } else {
      filteredData = data.where((item) {
        final ingredients = item['ingredients'].toString().toLowerCase();
        return searchTerms.every((term) => ingredients.contains(term));
      }).toList();
    }

    setState(() {});
  }

  void addNewInput() {
    TextEditingController newCon = TextEditingController();
    InputWidget newInp = InputWidget(
      controller: newCon,
      onChange: performSearch,
    );
    controllers.add(newCon);
    inputs.add(newInp);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    inputs[index],
                    IconButton(
                        onPressed: () {
                          inputs.removeAt(index);
                          controllers.removeAt(index);
                          setState(() {
                            performSearch();
                          });
                        },
                        icon: Icon(Icons.delete_forever_outlined,size:22.r))
                  ],
                );
              },
              childCount: inputs.length,
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate.fixed([
              GestureDetector(
                onTap: addNewInput,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  margin: EdgeInsets.symmetric(horizontal: 70.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "добавить ингредиент",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        Icons.add_circle_outline_outlined,
                        size: 22.r,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          // Ваши другие виджеты Sliver

          filteredData.isEmpty
              ?  SliverList(
                  delegate: SliverChildListDelegate.fixed([
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 50.h),
                    child: Center(
                        child: Column(
                      children: [
                        Text("Ничего не найдено",
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 2)),
                        Text("выберите ингредиенты",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 2)),
                      ],
                    )),
                  )
                ]))
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = filteredData[index];
                      return CookingTitleCard(cooking: Cooking.fromJson(item));
                    },
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    addSemanticIndexes: true,
                    semanticIndexCallback: (widget, index) => index,
                    childCount: filteredData.length,
                  ),
                ),
          // Другие виджеты Sliver
        ],
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  InputWidget({super.key, required this.controller, required this.onChange});
  TextEditingController controller;
  Function onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: SizedBox(
        width: 320.w,
        child: TextField(
          onChanged: (_) {
            onChange();
          },
          controller: controller,
          decoration: const InputDecoration(
            hintText: "ингредиент..",
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
