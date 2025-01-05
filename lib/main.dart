import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sobhanak_app/sobhanak_app.dart';

void main() async {
  await GetStorage.init();
  runApp(const SobhanakApp());
}
