import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/controller/RecentController.dart';
import '../PlayerScreen.dart';
import '../constants/constants.dart';
import '../../controller/playcontroller.dart';

class TestListView extends StatefulWidget {
  TestListView({
    Key? key,
  }) : super(key: key);

  @override
  State<TestListView> createState() => _TestListViewState();
}

class _TestListViewState extends State<TestListView> {
  playontroller controller = Get.put(playontroller());
  recentController recentcontroller = Get.put(recentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recentcontroller.queryRecent();
  }

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    final ThemeData themeData = Theme.of(context);
    return Obx(() {
      if (recentcontroller.recent.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenwidth / 2.9, vertical: screenheight / 4),
          child: Text(
            'No Recent Songs',
            //style: themeData.textTheme.headline6,
          ),
        );
      } else {
        List recent = recentcontroller.recent;
        return CarouselSlider.builder(
          itemCount: recent.length,
          itemBuilder: (context, i, id) {
            return GestureDetector(
              child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.expand,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Color.fromRGBO(2, 1, 1, 1),
                            )),
                        child: QueryArtworkWidget(
                          id: recent[i].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Icon(
                            Icons.music_note,
                            size: 200,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(
                            colors: [
                              themeData.primaryColor,
                              Colors.transparent,
                              Colors.transparent,
                              themeData.primaryColor
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, 0, 0.6, 1],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            recent[i].title,
                            //style: themeData.textTheme.headline6,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            recent[i].artist ?? "UnKnown",
                            //style: themeData.textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                  ]),
              onTap: () {},
            );
          },
          options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            enlargeCenterPage: true,
            height: 260,
            //aspectRatio: 4 / 4,
            viewportFraction: 0.6,
          ),
        );
      }
    });
  }
}
