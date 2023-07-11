import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/controller/PlayListController.dart';
import 'package:prototype/controller/SearchController.dart';

import 'constants/constants.dart';

class PlaylistSongs extends StatefulWidget {
  const PlaylistSongs({super.key});

  @override
  State<PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<PlaylistSongs> {
  PlayListController playListController = Get.put(PlayListController());
  int id = Get.arguments;
  @override
  void initState() {
    // TODO: implement initState
    playListController.querPlayListSongs(id);
    super.initState();
  }

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
                'Search',
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
          body: Obx(() {
            if (playListController.Playlist.isNotEmpty) {
              return ListView.builder(
                  itemCount: playListController.Playlist.length,
                  itemBuilder: ((context, index) {
                    SongModel song = playListController.fetch(index);
                    return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          leading: QueryArtworkWidget(
                            id: song.id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Container(
                              width: 50,
                              height: 50,
                              child: CircleAvatar(
                                  child: const Icon(Icons.music_note)),
                            ),
                          ),
                          title: Text(
                            song.title,
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: IconButton(
                            color: Color.fromARGB(255, 255, 255, 255),
                            onPressed: () {
                              playListController.removeFromPlaylist(
                                  id, playListController.Playlist[index].id);
                            },
                            icon: Icon(
                              Icons.delete,
                              //color: Colors.white,
                            ),
                          ),
                          subtitle: Text(song.artist ?? 'UnKnown'),
                          selectedTileColor:
                              const Color.fromARGB(255, 29, 28, 28)
                                  .withOpacity(0.5),
                        ));
                  }));
            } else {
              return const Center(child: Text('NO Songs Found'));
            }
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.play_circle),
          )),
    );
  }
}
