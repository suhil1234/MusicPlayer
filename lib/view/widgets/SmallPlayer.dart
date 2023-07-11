import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../controller/playcontroller.dart';

class smallPlayer extends StatefulWidget {
  const smallPlayer({super.key});

  @override
  State<smallPlayer> createState() => _smallPlayerState();
}

class _smallPlayerState extends State<smallPlayer> {
  playontroller controller = Get.put(playontroller());

  @override
  Widget build(BuildContext context) {
    List<SongModel> songs = controller.Songs;
    return Obx(() {
      return ListTile(
        leading: QueryArtworkWidget(
          id: controller.Songs[controller.currentStreamIndex.value].id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: Container(
            width: 50,
            height: 50,
            child: CircleAvatar(child: const Icon(Icons.music_note)),
          ),
        ),
        title: Text(
          songs[controller.currentStreamIndex.value].title,
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        subtitle: Text(
          songs[controller.currentStreamIndex.value].artist ?? 'UnKnown',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
        trailing: Obx(() {
          return Wrap(
            spacing: 0,
            children: [
              IconButton(
                color: Colors.deepPurple.shade800,
                onPressed: () {
                  controller.play();

                  //Get.to(const PlayerScreen());
                },
                icon: Icon(
                  (controller.isblaying.value == true)
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(Icons.skip_next,
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8)),
                onPressed: () {
                  controller.next();
                },
              ),
              IconButton(
                icon: Icon(Icons.cancel,
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8)),
                onPressed: () {
                  controller.smallPlayerVisibilty.value = false;
                  controller.stop();
                },
              ),
            ],
          );
        }),
        selectedTileColor:
            const Color.fromARGB(255, 29, 28, 28).withOpacity(0.5),
      );
    });
  }
}
