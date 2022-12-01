import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<List<dynamic>> readJson() async {
  final String response = await rootBundle.loadString('assets/data.json');
  return await json.decode(response);
}

Future<String> _localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}


Future<File> getFile(String filePath) async {
  final path = await _localPath();

  if(File(path).existsSync()) {
    return File('$path/$filePath');
  }
  return File('$path/$filePath').create();
}

Future<File> writeContent(String data, File file) async {
  return await file.writeAsString(data);
}

Future<String> readFile(File file) async {
  try {
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return 'Error';
  }
}

void deleteFile(File file) {
  file.delete();
}