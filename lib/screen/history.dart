import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getx/screen/home_screen.dart';
import 'package:getx/views_model/controller.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../record_list.dart';

class HistoryScreen extends StatefulWidget {
  
  const HistoryScreen({super.key,  });

  @override
  State<HistoryScreen> createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  
 late final Controller _controller ;
@override
  void initState(){
   _controller = Get.put(Controller());
   super.initState();
  }
@override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarix"),
      ),
      body: Column(
        children: [
           StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("tracker")
                        .where("userId",
                            isEqualTo: Provider.of<ProviderProfile>(context,
                                    listen: false)
                                .checkUser())
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("error");
                      }
                      return  SizedBox(
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot documentSnapshot =
                                    snapshot.data.docs[index];

                                return Card(
                                  color: Colors.lightBlueAccent,
                                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                                 child: Padding(
                                   padding: const EdgeInsets.all(18.0),
                                   child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(documentSnapshot["weight"],style:const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ) ,),
                                        Text(documentSnapshot["month"],
                                        style:const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        )
                                        
                                        ),
                                      ],
                                    ),
                                 ),
                                );
                              }),
                        );
                    
  })]
      ),
    );
  }
}
