import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx/screen/graphics.dart';
import 'package:getx/screen/home_screen.dart';
import 'package:getx/screen/history.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.red));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       appBarTheme: AppBarTheme(backgroundColor: Colors.black),
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

