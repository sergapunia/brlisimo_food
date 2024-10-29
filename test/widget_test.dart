import 'dart:convert';
import 'dart:io';

Future<dynamic> readJsonFromFile(String filePath) async {
  try {
    // Открыть файл для чтения
    final file = File(filePath);
    final stream = file.openRead();

    // Декодировать данные из потока
    final jsonData =
        await stream.transform(utf8.decoder).transform(json.decoder).toList();

    // Вернуть результат
    return jsonData.first;
  } catch (e) {
    print('Ошибка при чтении файла: $e');
    rethrow;
  }
}

void main() async {
  try {
    final jsonData = await readJsonFromFile('lib/data/data_base_js.json');
  } catch (e) {
    print('Ошибка: $e');
  }
}
