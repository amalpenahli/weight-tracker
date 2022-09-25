import 'dart:ffi';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:getx/screen/add_record.dart';
import 'package:getx/screen/graphics.dart';
import 'package:getx/screen/history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>_HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List page = [
   AddRecord(),
   HistoryScreen(),
   FlutterChart()

  ];

 

   @override
   Widget build(BuildContext context) {
     return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          
         
          items: const <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.history, size: 30),
            Icon(Icons.graphic_eq, size: 30),
          ],
         color: Colors.white,
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.lightBlueAccent,
        animationCurve: Curves.easeOutCirc,
        animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
  //
         body: page[currentIndex]
           );
   }
  }