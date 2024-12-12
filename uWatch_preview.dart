import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_login/display_components.dart';
import 'package:firebase_login/videodataprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UWatchPreviewScreen extends StatefulWidget {
  final Map<String, dynamic> videoData;
  const UWatchPreviewScreen({super.key, required this.videoData});

  @override
  State<UWatchPreviewScreen> createState() => _UWatchPreviewScreenState();
}

class _UWatchPreviewScreenState extends State<UWatchPreviewScreen> {
  final Color primaryColor = const Color(0xFF78DF81);
  @override
  Widget build(BuildContext context) {
    final videoDataProvider = Provider.of<VideoDataProvider>(context);
    var isLikedVideo = videoDataProvider.likedVideoIds.contains(widget.videoData['id'].toString());
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                style: IconButton.styleFrom(backgroundColor: Colors.black54),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.more_vert_sharp),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.videoData['thumbnailUrl'],
                    fit: BoxFit.cover,
                    height: 400,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black87
                          ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.videoData['title'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "2023 · ${widget.videoData['playlistName']} · Series",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          const SizedBox(height: 5,),

                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "⭐${widget.videoData['rating']}/5.0",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                            TextSpan(
                              text: " (${widget.videoData['numberOfReviews']} reviews)",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 12),
                            )
                          ])),
                          const SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: null,
                    child: RectangleButtons(
                      title: 'Play',
                      displayIcon: CupertinoIcons.play_arrow,
                      primaryColor: primaryColor,
                    )
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: null,
                    child: const RectangleButtons(
                      title: ' Watch Trailer',
                      displayIcon: Icons.movie_creation_outlined,
                      primaryColor: Colors.white,
                    )
                  ),
                ],
              ),
              const SizedBox(height: 20,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(isLikedVideo){
                            videoDataProvider.removeLikedVideoIds(widget.videoData['id'].toString());
                          }else{
                            videoDataProvider.addLikedVideoIds(widget.videoData['id'].toString());
                          }
                        },

                        child: CircleAvatar(
                          backgroundColor:
                          isLikedVideo ? primaryColor : const Color(0xFF262930),
                          radius: 25,
                          child: Icon(isLikedVideo ? Icons.done : Icons.add, size: 32, color: Colors.white,),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                        "Add to Lists",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 11),
                      )
                    ],
                  ),
                   Column(
                    children: [
                      GestureDetector(
                        onTap: () => showRatingsPopup(context, widget.videoData['id']),
                        child: const CircleAvatar(
                          backgroundColor: Color(0xFF262930),
                          radius: 25,
                          child: Icon(Icons.thumb_up_sharp, size: 28, color: Colors.white,),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                        "Rate",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 11),
                      )
                    ],
                  ),
                  const Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFF262930),
                        radius: 25,
                        child: Icon(Icons.share, size: 28, color: Colors.white,),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Recommend",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 11),
                      )
                    ],
                  )
                ],
              ),

              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ExpandableText(
                    widget.videoData['description'],
                    expandText: 'show more',
                  collapseText: 'show less',
                  style: const TextStyle(color: Colors.grey),
                  linkColor: primaryColor,
                ),
              ),


              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Text(
                  "Recommended",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),

              ListView.builder(
                padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:videoDataProvider.mapData.length,
                  itemBuilder: (context, index) => VideoTile(videoData: videoDataProvider.mapData[index],)
              )
            ],
          ),
        ),
      ),
    );
  }
}
