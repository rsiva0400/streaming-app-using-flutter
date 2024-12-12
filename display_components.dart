import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_login/uWatch_preview.dart';
import 'package:firebase_login/videodataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';


class RectangleButtons extends StatelessWidget {
  final Color primaryColor;
  final String title;
  final IconData displayIcon;
  const RectangleButtons({super.key, required this.primaryColor, required this.title, required this.displayIcon });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.4,
      height: 50,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            displayIcon,
            size: 24,
            color: Colors.black87,
          ),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 16),
          )
        ],
      ),
    );
  }
}


void showRatingsPopup(BuildContext context, int videoId) {
  double finalRating = 3;
  final videoDataProvider = Provider.of<VideoDataProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Ratings'),
            content: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  finalRating = rating; // Update the rating value
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  videoDataProvider.addRatings(videoId, finalRating);
                  Navigator.of(context).pop();
                  print(finalRating); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        }
      );
    },
  );
}


class VideoTile extends StatelessWidget {
  final Map<String, dynamic> videoData;
  const VideoTile({super.key, required this.videoData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UWatchPreviewScreen(videoData: videoData,)));
      },
      child: Column(
        children: [
          Stack(
            children: [
              imageLoader(videoData['thumbnailUrl']),
              Positioned(
                top: 170,
                left: MediaQuery.of(context).size.width - 50,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(3)
                  ),
                  child: Text(
                    videoData['duration'],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,),
                ),
              )
            ],
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              backgroundImage: CachedNetworkImageProvider(videoData['playlistThumbnailUrl']),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  videoData['title'],
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "${videoData['playlistName']} · 469K views · 4 days ago",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            trailing: const Icon(Icons.more_vert, color: Colors.white,),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}


class WatchTile extends StatelessWidget {
  final Map<String, dynamic> videoData;
  const WatchTile({super.key, required this.videoData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => UWatchPreviewScreen(videoData: videoData,))
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: videoData['thumbnailUrl'],
                  height: 150,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 150,
                    width: 150 * (16/9),
                    color: Colors.black,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
            ),
            Positioned.fill(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(1)
                        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ListTile(
                        title: Text(
                          videoData['title'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 13),
                        ),
                        subtitle: Text(
                          videoData['playlistName'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                              fontSize: 11),
                        ),
                        trailing: const Icon(Icons.play_arrow, color: Colors.white, size: 24,)
                      ),
                    )
                )
            ),

          ],
        ),
      ),
    );
  }
}

Widget imageLoader(String url){
  return AspectRatio(
    aspectRatio: 16/9,
    child: CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
}