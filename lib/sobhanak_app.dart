import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak_app/view/home/home_screen.dart';

class SobhanakApp extends StatelessWidget {
  const SobhanakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(fontFamily: 'UthmanicHafs_V22'),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false);
  }
}