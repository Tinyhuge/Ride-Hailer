import 'package:flutter/material.dart';
import 'package:ride_hailer/src/user/pages/extra/splash_screen.dart';
import 'package:ride_hailer/src/user/pages/home/home_screen.dart';
import 'package:ride_hailer/src/user/pages/home/map_search_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Techie Rider',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home:SplashScreen()
      //home: MapSearchScreen(),
    );
  }
}
