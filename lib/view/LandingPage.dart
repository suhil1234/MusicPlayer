// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/RecentPage.dart';
import 'package:prototype/view/SearchPage.dart';
import '../controller/RecentController.dart';
import '../controller/playcontroller.dart';
import '../view/widgets/CustomAppBar.dart';
import '../view/widgets/TestList.dart';
import '../view/widgets/searchbar.dart';
import 'package:prototype/controller/favoriteController.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var controller = Get.put(playontroller());
  favoriteController favcontroller = Get.put(favoriteController());
  recentController recentcontroller = Get.put(recentController());
  @override
  void initState() {
    // TODO: implement initState
    favcontroller.queryFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets sidePadding = EdgeInsets.only(left: 18, right: 18);
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: const customAppBar(
        text: 'My Player',
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: sidePadding,
              child: Text(
                'welcome',
                //style: themeData.textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: sidePadding,
              child: Text(
                'Enjoy your favorite music',
                style: themeData.textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            searchbar(),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: sidePadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(RecentPage());
                    },
                    child: Text(
                      'Recently Played',
                      style: themeData.textTheme.titleMedium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      recentcontroller.clearRecent();
                    },
                    child: Text(
                      'Clear Recent',
                      //style: themeData.textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TestListView(),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
