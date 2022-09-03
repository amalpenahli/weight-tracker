import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  int _currentTab = 0;
  Widget _currentScreen = MyHomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
     body: _currentScreen,
     floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: (){
        Get.to(()=>AddRecord());
      },
      child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      bottomNavigationBar: AnimatedBottomNavigationBar(
        height: Get.height/12,
        activeColor: Colors.white,
        inactiveColor: Colors.red,
        gapLocation: GapLocation.center,
        backgroundColor: Colors.black,
        
        icons: [Icons.show_chart,Icons.history,],
        iconSize: 30,
         activeIndex:_currentTab , onTap: (int ) { 
          setState(() {
            _currentTab = int;
            _currentScreen=(int ==0)?MyHomePage():HistoryScreen();
          });
          
          print(_currentTab);
          },),
    );
  }
}