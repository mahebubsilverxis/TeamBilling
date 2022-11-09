import 'package:flutter/material.dart';

class AppLanguage {
  ///Default Language
  static Locale defaultLanguage = Locale("de");

  ///List Language support in Application
  static List<Locale> supportLanguage = [
    Locale("en"),
    Locale("de"),
  ];

  ///Singleton factory
  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();
}
