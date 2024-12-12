import 'package:firebase_login/display_components.dart';
import 'package:firebase_login/videodataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videoDataProvider = Provider.of<VideoDataProvider>(context);
    final likedVideos = videoDataProvider.mapData
        .where((video) => videoDataProvider.likedVideoIds.contains(video['id'].toString()))
        .toList();
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.black54),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
            ),
          ),
          body: likedVideos.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: likedVideos.length,
                  itemBuilder: (context, index) {
                    return VideoTile(videoData: likedVideos[index]);
                  })
              : const Center(child: Text("EMPTY", style: TextStyle(color: Colors.white),),)),
    );
  }
}
