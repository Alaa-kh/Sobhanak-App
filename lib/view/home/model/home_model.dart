import 'package:flutter/material.dart';

class HomeModel {
  final String text;
  final Icon icon;

  HomeModel(this.text, this.icon);
}

List<HomeModel> homeModelList = [
  HomeModel('داكن', const Icon(Icons.dark_mode)),
  HomeModel('تصفير', const Icon(Icons.settings_backup_restore_outlined)),
  HomeModel('الصوت', const Icon(Icons.settings_backup_restore_outlined)),
  HomeModel('أذكارك', const Icon(Icons.auto_stories)),
  HomeModel('تواصل', const Icon(Icons.email))
];
