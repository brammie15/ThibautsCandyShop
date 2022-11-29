import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<dynamic>> readJson() async {
  final String response = await rootBundle.loadString('assets/data.json');
  return await json.decode(response);
}