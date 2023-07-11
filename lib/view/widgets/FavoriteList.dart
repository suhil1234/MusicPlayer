import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/controller/favoriteController.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/controller/playcontroller.dart';
import 'package:prototype/view/widgets/showToast.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  favoriteController controller = Get.put(favoriteController());
  playontroller playcontroller = Get.put(playontroller());

  @override
  void initState() {
    // TODO: implement initState
    controller.queryFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.favorite.isNotEmpty) {
        return ListView.builder(
            itemCount: controller.favorite.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      leading: QueryArtworkWidget(
                        id: controller.favorite[index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Container(
                          width: 50,
                          height: 50,
                          child:
                              CircleAvatar(child: const Icon(Icons.music_note)),
                        ),
                      ),
                      title: Text(
                        controller.favorite[index].title,
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: Wrap(children: [
                        IconButton(
                            color: Color.fromARGB(255, 255, 255, 255),
                            onPressed: () {
                              controller.removefromFav(
                                  controller.favorite[index], index);
                              controller.savefav(
                                  controller.favorite[index].title, false);
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )),
                      ]),
                      selectedTileColor: const Color.fromARGB(255, 29, 28, 28)
                          .withOpacity(0.5),
                    ),
                  ));
            }));
      } else {
        return const Center(child: Text('NO Favorite Songs'));
      }
    });
  }
}
