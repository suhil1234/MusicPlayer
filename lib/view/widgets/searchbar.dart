// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/controller/SearchController.dart';
import 'package:prototype/main.dart';
import '../../controller/playcontroller.dart';
import '../SearchPage.dart';
import '../constants/constants.dart';

class searchbar extends StatelessWidget {
  const searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    playontroller controller = Get.put(playontroller());
    double screenwidth = MediaQuery.of(context).size.width;
    SearchController searchController = Get.put(SearchController());
    final ThemeData themeData = Theme.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () {
            Get.to(SearchPage());
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                )),
            child: Center(
              child: ListTile(
                leading: Icon(
                  Icons.search,
                  color: themeData.splashColor,
                ),
                title: Text(
                  'Search Your Favrouite Song',
                  //style: themeData.textTheme.headline6,
                ),
              ),
            ),
          ),
        ));
  }
}
