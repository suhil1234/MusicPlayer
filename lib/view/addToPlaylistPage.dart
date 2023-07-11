import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/view/constants/constants.dart';

import '../controller/PlayListController.dart';
import '../controller/playcontroller.dart';

class addToPlaylistPage extends StatefulWidget {
  const addToPlaylistPage({super.key});

  @override
  State<addToPlaylistPage> createState() => _addToPlaylistPageState();
}

class _addToPlaylistPageState extends State<addToPlaylistPage> {
  playontroller controller = Get.put(playontroller());
  PlayListController playlistcontroller = Get.put(PlayListController());
  int id = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: background(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
            child: Text(
              'Add To Playlist',
              style: TextStyle(color: Colors.white),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
        ),
        backgroundColor: Colors.transparent,
        body: ListView.builder(
            itemCount: controller.Songs.length,
            itemBuilder: ((context, index) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    leading: QueryArtworkWidget(
                      id: controller.Songs[index].id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: Container(
                        width: 50,
                        height: 50,
                        child:
                            CircleAvatar(child: const Icon(Icons.music_note)),
                      ),
                    ),
                    title: Text(
                      controller.Songs[index].title,
                      style: TextStyle(fontSize: 15),
                    ),
                    subtitle: Text(controller.Songs[index].artist ?? 'UnKnown'),
                    trailing: StarButton(
                      iconSize: 40,
                      isStarred: playlistcontroller.loadfromPlayList(
                          id, controller.Songs[index].id),
                      valueChanged: (v) async {
                        v == false
                            ? await playlistcontroller.removeFromPlaylist(
                                id, controller.Songs[index].id)
                            : await playlistcontroller.addToPlaylist(
                                id, controller.Songs[index].id);
                      },
                    ),
                    selectedTileColor:
                        const Color.fromARGB(255, 29, 28, 28).withOpacity(0.5),
                  ));
            })),
      ),
    );
  }
}
