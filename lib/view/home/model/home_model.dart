import 'package:flutter/material.dart';

class HomeModel {
  final String text;
  final Icon icon;

  HomeModel(this.text, this.icon);
}

List<HomeModel> homeModelList = [
  HomeModel('تصفير',
      Icon(Icons.settings_backup_restore_outlined, color: Colors.white)),
  HomeModel('تصفير',
      Icon(Icons.settings_backup_restore_outlined, color: Colors.white)),
  HomeModel('تصفير',
      Icon(Icons.settings_backup_restore_outlined, color: Colors.white)),
  HomeModel('أذكارك', Icon(Icons.note_add, color: Colors.white)),
];
