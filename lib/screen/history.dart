import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getx/screen/home_screen.dart';
import 'package:getx/views_model/controller.dart';

import '../record_list.dart';

class HistoryScreen extends StatefulWidget {
  
  const HistoryScreen({super.key,  });

  @override
  State<HistoryScreen> createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  final Controller _controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: Text("Tarix "),
          actions: [
            IconButton(
                onPressed: () {
                  _controller.addRecord();
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: _controller.records.isEmpty
            ? Center(child: Container(child: Text("bir sey elave edin")))
            : ListView(
                physics: BouncingScrollPhysics(),
                children: _controller.records
                    .map((record) => RecordList(record: record))
                    .toList())));
  }
}
