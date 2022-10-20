import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:getx/model/record.dart';
import 'package:getx/views_model/controller.dart';
import 'package:intl/intl.dart';

class RecordList extends StatelessWidget {
  final Record record;
   RecordList({super.key, required this.record});
   final  Controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
   
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(top:8.0,bottom: 8),
        child: ListTile(
          leading: _buildData(),
          title: _buildWeight(),
          trailing: _buildIcons(),
        ),
      ),
    );
  }

  Row _buildIcons() {
    return Row(
       mainAxisSize: MainAxisSize.min,
          children: [
        
            IconButton(onPressed: null, icon: Icon(Icons.edit,color: Colors.grey,)),
            IconButton(onPressed: (() {
              _controller.deleteRecord(record);
            }),
            
            
            
            icon: Icon(Icons.delete,color: Colors.red,))
          ],
        );
  }

  Center _buildWeight() => Center(child: Text("${record.weight}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),));

  Text _buildData() => Text(DateFormat('EEE,MMM d').format(record.dateTime));
}