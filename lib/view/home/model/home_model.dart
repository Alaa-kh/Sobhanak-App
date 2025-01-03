import 'package:flutter/material.dart';

class HomeModel {
  final String text;
  final Icon icon;

  HomeModel(this.text, this.icon);
}

List<HomeModel> homeModelList = [
  HomeModel('داكن', Icon(Icons.dark_mode)),
  HomeModel('الاهتزاز',
      Icon(Icons.vibration)),
  HomeModel('تصفير',
      Icon(Icons.settings_backup_restore_outlined)),
  HomeModel('تصفير',
      Icon(Icons.settings_backup_restore_outlined)),
  HomeModel('أذكارك', Icon(Icons.note_add)),
];
