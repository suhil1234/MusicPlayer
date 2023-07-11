import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../view/constants/constants.dart';
import '../../controller/ThemeController.dart';
import '../../model/Themes.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<ThemeData> themes = Themes().themes;
  List<String> names = Themes().names;
  ThemeController controller = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: background(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // ignore: prefer_const_constructors
          title: const Text(
            'Themes',
            style: TextStyle(color: Colors.white),
          ),

          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: EdgeInsets.only(
              top: hieght / 3,
            ),
            child: CarouselSlider.builder(
              carouselController: CarouselController(),
              itemCount: themes.length,
              itemBuilder: (context, i, id) {
                controller.isSelectedColor.value =
                    i == controller.currentThemeIndex.value;
                return GestureDetector(
                  onTap: controller.isSelectedColor.value
                      ? null
                      : () {
                          controller.currentThemeIndex.value = i;
                          controller.changeTheme(i);
                        },
                  child: Container(
                    decoration: shaderDecoration(
                            context,
                            themes[i].primaryColor,
                            themes[i].colorScheme.secondary)
                        .copyWith(
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(color: Colors.white)),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: controller.isSelectedColor.value ? 1 : 0,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Container(
                            height: 100,
                            width: 100,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                reverse: true,
                autoPlay: true,
                enlargeCenterPage: true,
                height: 260,
                initialPage: controller.currentThemeIndex.value,
                viewportFraction: 0.6,
              ),
            )),
      ),
    );
  }
}
