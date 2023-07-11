// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_types_as_parameter_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:on_audio_room/on_audio_room.dart';
import '../../controller/ThemeController.dart';
import '../../model/Themes.dart';
import 'package:get/get.dart';
import 'Routes/app_pages.dart';
import 'Routes/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../controller/playcontroller.dart';

ThemeController controller = Get.put(ThemeController());
playontroller playercontroller = Get.put(playontroller());
Future<void> main() async {
  await OnAudioRoom().initRoom();
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get themes => Themes().themes;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.Navigation,
        getPages: AppPages.list,
        theme: controller.gett());
  }
}
