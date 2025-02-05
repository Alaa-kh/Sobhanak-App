import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sobhanak_/sobhanak_app.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SobhanakApp());
}
