
import 'package:firebase_login/localdata.dart';
import 'package:firebase_login/uWatch.dart';
import 'package:firebase_login/videodataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPref.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => VideoDataProvider()..fetchMapData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.white,
          )
        ),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const UWatchScreen(),
    );
  }
}

