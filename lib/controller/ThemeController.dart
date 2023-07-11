import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/Themes.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  RxInt currentThemeIndex = 0.obs;
  RxBool isSelectedColor = false.obs;
  List<ThemeData> themes = Themes().themes;
  final box = Hive.box('myBox');

  changeTheme(int i) async {
    currentThemeIndex.value = i;
    Get.changeTheme(themes[currentThemeIndex.value]);
    await box.put('index', i);
  }

  ThemeData gett() {
    return themes[getindex()];
  }

  getindex() {
    return currentThemeIndex.value = box.get('index') ?? 0;
  }
}
