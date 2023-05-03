import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocaleController extends GetxController {
  void changeLanguage(String LangCode) {
    Locale local = Locale(LangCode);
    //.setString("langcode", LangCode);
    Get.updateLocale(local);
  }
}
