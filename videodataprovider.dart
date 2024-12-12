import 'package:firebase_login/localdata.dart';
import 'package:flutter/material.dart';

class VideoDataProvider with ChangeNotifier {
  // List of maps to store the data
  List<Map<String, dynamic>> _mapData = [];

  // Getter to access the map data
  List<Map<String, dynamic>> get mapData => _mapData;

  List<String> _likedVideoIds = [];

  // Getter to access the map data
  List<String> get likedVideoIds => _likedVideoIds;

  List<String> _history = [];

  // Getter to access the map data
  List<String> get history => _history;

  // Function to fetch initial data
  void fetchMapData() {
    _likedVideoIds = MySharedPref.getList('likedVideoIds');
    _mapData = [
      {
        'id': 1,
        'title': 'Flutter State Management',
        'description': 'Learn the basics of state management in Flutter. Explore Provider, Riverpod, and more. Perfect for beginners and pros alike!',
        'playlistName': 'Flutter Essentials',
        'playlistThumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/1.jpg',
        'rating': 4.8,
        'numberOfReviews': 150,
        'thumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/1.jpg',
        'duration': '12:45',
      },
      {
        'id': 2,
        'title': 'Introduction to Dart',
        'description': 'A comprehensive guide to Dart programming. From variables to async/await, master the foundation of Flutter development.',
        'playlistName': 'Dart for Beginners',
        'playlistThumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/2.jpg',
        'rating': 4.7,
        'numberOfReviews': 120,
        'thumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/2.jpg',
        'duration': '15:30',
      },
      {
        'id': 3,
        'title': 'Building Responsive UIs',
        'description': 'Understand the principles of building responsive user interfaces in Flutter. Ideal for dynamic screen sizes and orientations.',
        'playlistName': 'Flutter UI/UX',
        'playlistThumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/3.jpg',
        'rating': 4.9,
        'numberOfReviews': 180,
        'thumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/3.jpg',
        'duration': '10:20',
      },
      {
        'id': 4,
        'title': 'Working with APIs in Flutter',
        'description': 'Learn how to connect your Flutter app to REST APIs. Includes hands-on examples with JSON parsing and error handling.',
        'playlistName': 'Flutter Networking',
        'playlistThumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/4.jpg',
        'rating': 4.6,
        'numberOfReviews': 110,
        'thumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/4.jpg',
        'duration': '18:05',
      },
      {
        'id': 5,
        'title': 'Animations in Flutter',
        'description': 'Master Flutter animations to create smooth, delightful user experiences. Covers implicit and explicit animations.',
        'playlistName': 'Flutter Animations',
        'playlistThumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/5.jpg',
        'rating': 4.8,
        'numberOfReviews': 140,
        'thumbnailUrl': 'https://ik.imagekit.io/zk2duiefh/Thumbnails/5.jpg',
        'duration': '22:15',
      },
    ];
    _history = MySharedPref.getList('history');

    notifyListeners();
  }

  void addLikedVideoIds(String videoId) async {
    _likedVideoIds = await MySharedPref.addToList('likedVideoIds', videoId);
    print(_likedVideoIds);
    notifyListeners();
  }

  void removeLikedVideoIds(String videoId) async {
    _likedVideoIds = await MySharedPref.removeFromList('likedVideoIds', videoId);
    print(_likedVideoIds);
    notifyListeners();
  }

  // Function to edit an existing map entry by ID
  void editMapData(int id, Map<String, dynamic> newData) {
    final index = _mapData.indexWhere((map) => map['id'] == id);
    if (index != -1) {
      _mapData[index] = newData;
      notifyListeners();
    }
  }

  // Function to add a new map entry
  void addMapData(Map<String, dynamic> newEntry) {
    _mapData.add(newEntry);
    notifyListeners();
  }

  // Function to remove a map entry by ID
  void removeMapData(int id) {
    _mapData.removeWhere((map) => map['id'] == id);
    notifyListeners();
  }

  void addRatings(int id, double rating) {
    final index = _mapData.indexWhere((map) => map['id'] == id);
    if (index != -1) {
      double newRating = (_mapData[index]['rating'] * _mapData[index]['numberOfReviews'] + rating) / (_mapData[index]['numberOfReviews'] +1);
      _mapData[index]['rating'] = double.parse(newRating.toString().substring(0,3));
      _mapData[index]['numberOfReviews'] = _mapData[index]['numberOfReviews']+1;
      notifyListeners();
    }
  }
}
