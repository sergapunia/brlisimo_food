import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;

class DataBase {
  static List<Map<String, dynamic>> data = [];

  static Future<void> getDataBase() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/data_base_js.json');
      List<dynamic> jsonData = json.decode(jsonString);
      String jsonString2 =
          await rootBundle.loadString('assets/data_base_js_2.json');
      List<dynamic> jsonData2 = json.decode(jsonString2);
      List<Map<String, dynamic>> dt1 = jsonData.cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> dt2 = jsonData2.cast<Map<String, dynamic>>();
      data = [...dt1, ...dt2];
      log("Данные загружены");
    } catch (e) {
      log("ошибка загрузки данных $e");
      getDataBase();
    }
  }
}
