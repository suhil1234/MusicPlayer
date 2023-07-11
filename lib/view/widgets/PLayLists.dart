import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/view/PlayListSongs.dart';
import 'package:prototype/view/addToPlaylistPage.dart';

import '../../controller/PlayListController.dart';
import '../../controller/playcontroller.dart';
import '../PlayerScreen.dart';

class PlayLists extends StatefulWidget {
  const PlayLists({super.key});

  @override
  State<PlayLists> createState() => _PlayListsState();
}

class _PlayListsState extends State<PlayLists> {
  PlayListController controller = Get.put(PlayListController());
  @override
  void initState() {
    // TODO: implement initState
    controller.queryplaylists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.playlists.isNotEmpty) {
        return ListView.builder(
            itemCount: controller.playlists.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                  onTap: () {
                    Get.to(PlaylistSongs(),
                        arguments: controller.playlists[index].id);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      leading: QueryArtworkWidget(
                        id: controller.playlists[index].id,
                        type: ArtworkType.PLAYLIST,
                        nullArtworkWidget: Container(
                          width: 50,
                          height: 50,
                          child:
                              CircleAvatar(child: const Icon(Icons.music_note)),
                        ),
                      ),
                      title: Text(
                        controller.playlists[index].playlist,
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: Wrap(children: [
                        IconButton(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          onPressed: () {
                            Get.to(const addToPlaylistPage(),
                                arguments: controller.playlists[index].id);
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          color: Color.fromARGB(255, 255, 255, 255),
                          onPressed: () {
                            controller.removeeplayList(
                                controller.playlists[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            //color: Colors.white,
                          ),
                        ),
                      ]),
                      selectedTileColor: const Color.fromARGB(255, 29, 28, 28)
                          .withOpacity(0.5),
                    ),
                  ));
            }));
      } else {
        return Center(child: Text('NO playlists found'));
      }
    });
  }
}
