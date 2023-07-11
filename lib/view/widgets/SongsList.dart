import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/controller/playcontroller.dart';

import '../../controller/RecentController.dart';
import '../../controller/favoriteController.dart';
import '../PlayerScreen.dart';

class SongsList extends StatefulWidget {
  const SongsList({super.key});

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  playontroller controller = Get.put(playontroller());
  favoriteController favcontroller = Get.put(favoriteController());
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FutureBuilder<List<SongModel>>(
        future: controller.audio.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            controller.Songs = snapshot.data!;
            controller.initilalize();
            print(controller.Songs.length);
            return ListView.builder(
                itemCount: controller.Songs.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                      onTap: () {
                        if (controller.currentStreamIndex.value == index) {
                          Get.to(const PlayerScreen(),
                              arguments: controller.Songs);
                        } else {
                          controller.currentStreamIndex.value = index;

                          Get.to(const PlayerScreen(),
                              arguments: controller.Songs);
                          controller.playNew();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          leading: QueryArtworkWidget(
                            id: controller.Songs[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Container(
                              width: 50,
                              height: 50,
                              child: CircleAvatar(
                                  child: const Icon(Icons.music_note)),
                            ),
                          ),
                          title: Text(
                            controller.Songs[index].title,
                            style: TextStyle(fontSize: 14),
                          ),
                          subtitle: Text(
                            controller.Songs[index].artist ?? 'UnKnown',
                            style: TextStyle(fontSize: 12),
                          ),
                          trailing: Obx(() {
                            return IconButton(
                              color: Color.fromARGB(255, 255, 255, 255),
                              onPressed: () {
                                if (controller.currentStreamIndex.value ==
                                    index) {
                                  if (controller.isblaying == true) {
                                    controller.pause();
                                  } else {
                                    controller.resume();
                                  }
                                } else {
                                  controller.currentStreamIndex.value = index;
                                  controller.playNew();
                                }
                              },
                              icon: Icon(
                                (controller.isblaying.value == true &&
                                        controller.currentStreamIndex.value ==
                                            index)
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            );
                          }),
                          selectedTileColor:
                              const Color.fromARGB(255, 29, 28, 28)
                                  .withOpacity(0.5),
                        ),
                      ));
                }));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
