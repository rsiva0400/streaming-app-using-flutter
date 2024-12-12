import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_login/display_components.dart';
import 'package:firebase_login/uWatch_favourites.dart';
import 'package:firebase_login/uWatch_preview.dart';
import 'package:firebase_login/videodataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UWatchScreen extends StatefulWidget {

  
  const UWatchScreen({super.key});

  @override
  State<UWatchScreen> createState() => _UWatchScreenState();
}

class _UWatchScreenState extends State<UWatchScreen> {

  final Color primaryColor = const Color(0xFF78DF81);
  @override
  Widget build(BuildContext context) {
    final videoDataProvider = Provider.of<VideoDataProvider>(context);
    final videosData = videoDataProvider.mapData;
    return Scaffold(

      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.black,
            backgroundImage: CachedNetworkImageProvider(videosData[0]['thumbnailUrl']),
          ),
        ),
        title: const Text('uWatch',
            style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => const FavouritesScreen())
              );
            },
              icon: const Icon(
                Icons.favorite,
                size: 28,
                color: Colors.grey,
              )
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),

            // Now trending Block
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Now Trending",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 18),
              ),
            ),

            // Featured video Block
            Stack(
              children: [
                imageLoader(videosData[0]['thumbnailUrl']),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(1)
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ListTile(
                        title: Text(
                          videosData[0]['title'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        subtitle: Text(
                          videosData[0]['playlistName'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 12),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UWatchPreviewScreen(videoData: videosData[0],))
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Icon(Icons.play_arrow_outlined, color: Color(0xFF262930), size: 32,),
                          ),
                        )
                      ),
                    )
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),

            // Continue Watching text Block
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Continue Watching",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 18),
              ),
            ),

            // Continue Watching  Block
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    videosData.length,
                        (index) => WatchTile(videoData: videosData[index])
                ),
              ),
            ),

            // Recent text Block
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Recent",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 18),
              ),
            ),

            // Recent videos Block
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:videosData.length,
                itemBuilder: (context, index) => VideoTile(videoData: videosData[index])
            )

          ],
        ),
      ),
    );
  }
}

