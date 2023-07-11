import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controller/RecentController.dart';
import 'constants/constants.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  recentController recentcontroller = Get.put(recentController());
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: background(context),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Recent Songs',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back)),
          ),
          backgroundColor: Colors.transparent,
          body: Obx(() {
            if (recentcontroller.recent.isNotEmpty) {
              List recent = recentcontroller.recent;
              return ListView.builder(
                  itemCount: recent.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            leading: QueryArtworkWidget(
                              id: recent[index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Container(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                    child: const Icon(Icons.music_note)),
                              ),
                            ),
                            title: Text(
                              recent[index].title,
                              style: TextStyle(fontSize: 15),
                            ),
                            selectedTileColor:
                                const Color.fromARGB(255, 29, 28, 28)
                                    .withOpacity(0.5),
                          ),
                        ));
                  }));
            } else {
              return const Center(child: Text('NO Recent Songs'));
            }
          }),
        ));
  }
}
