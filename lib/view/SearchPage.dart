import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/controller/SearchController.dart';
import 'package:prototype/main.dart';
import 'package:prototype/view/constants/constants.dart';
import '../../controller/playcontroller.dart';
import 'widgets/CustomAppBar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchController searchController = Get.put(SearchController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.SearchList.value = [];
  }

  @override
  Widget build(BuildContext context) {
    playontroller controller = Get.put(playontroller());
    double screenwidth = MediaQuery.of(context).size.width;

    final ThemeData themeData = Theme.of(context);
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
          body: Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.4),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.4),
                          )),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'search',
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    searchController.changeSearchList(value);
                  },
                ),
                Expanded(
                  child: Obx(() {
                    if (searchController.SearchList.isNotEmpty) {
                      return ListView.builder(
                          itemCount: searchController.SearchList.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 4),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    leading: QueryArtworkWidget(
                                      id: searchController.SearchList[index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: Container(
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                            child:
                                                const Icon(Icons.music_note)),
                                      ),
                                    ),
                                    title: Text(
                                      searchController.SearchList[index].title,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    subtitle: Text(searchController
                                            .SearchList[index].artist ??
                                        'UnKnown'),
                                    selectedTileColor:
                                        const Color.fromARGB(255, 29, 28, 28)
                                            .withOpacity(0.5),
                                  ),
                                ));
                          }));
                    } else {
                      return const Center(
                        child: Text('No Songs Found'),
                      );
                    }
                  }),
                )
              ],
            ),
          )),
    );
  }
}
