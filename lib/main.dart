import 'package:flutter/material.dart';

import 'screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor:const Color(0xff131410),
      ),
      home:const LoadingScreen(),
      // home: const LocationScreen(),
    );
  }
}
