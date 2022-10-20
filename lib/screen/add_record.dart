import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx/constants/constants.dart';
import 'package:getx/screen/drawer_screen.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../views_model/controller.dart';
import '../widgets/drawer_card.dart';
import 'auth/login.dart';
import 'graphics.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({Key? key}) : super(key: key);

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  final Controller controller = Get.put(Controller());
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _firebaseAuth;
  late final User currentUser;
  late final CollectionReference usersCollection;
  late final CollectionReference trackerCollection;
  late DateTime selectedDate;
  late final DateTime dateNow;
  late final TextEditingController noteController;
  late final TextEditingController nameController;
  String _note = "Qeyd əlavə et";

  @override
  void initState() {
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    currentUser = _firebaseAuth.currentUser!;
    usersCollection = _firestore.collection('users');
    trackerCollection = _firestore.collection('tracker');
    dateNow = DateTime.now();
    selectedDate = dateNow;
    noteController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  // getRecord() {
  //   usersCollection.doc().get().then((value) {
  //     if (value.exists) {
  //       print('Document exists on the database');
  //       print(value.data()!['currentYear']);
  //     }
  //     // print(value.data()!['year'].toString());
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Əlavə et"),
          centerTitle: true,
        ),
        drawer: const DrawerScreen(),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/weight_image.jpeg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        FontAwesomeIcons.weightScale,
                        size: 40,
                        color: Colors.white,
                      ),
                      Stack(alignment: Alignment.bottomCenter, children: [
                        NumberPicker(
                            itemCount: 3,
                            itemWidth: 80,
                            itemHeight: 50,
                            step: 1,
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            axis: Axis.horizontal,
                            minValue: 40,
                            maxValue: 130,
                            value: Controller.selectedvalue,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white)),
                            onChanged: (value) {
                              setState(() {
                                Controller.selectedvalue = value;
                              });

                              print(value);
                            }),
                        const Icon(
                          FontAwesomeIcons.chevronUp,
                          size: 16,
                          color: Colors.white,
                        )
                      ])
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (() {
                  datePicker(context);
                }),
                child: Card(
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          FontAwesomeIcons.calendar,
                          size: 40,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Text(
                            DateFormat('EEE, MMM d,' 'yy').format(selectedDate),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (() {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Qeyd  əlavə et"),
                          content: TextField(
                            controller: noteController,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  _note = noteController.text;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  });
                }),
                child: Card(
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          FontAwesomeIcons.noteSticky,
                          size: 40,
                          color: Colors.white,
                        ),
                        Expanded(
                            child: Text(
                          _note,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    createInfo();

                    setState(() {});
                  },
                  child: const Text(
                    "yadda saxla",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  createInfo() {
    DocumentReference documentReference = trackerCollection.doc();

    Map<String, String> info = {
      "weight": Controller.selectedvalue.toString(),
      "month": DateFormat('EEE, MMM d,' 'yy').format(selectedDate),
      "userId": currentUser.uid
    };
    documentReference.set(info).whenComplete(() => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const FlutterChart())),
        });
  }

  void datePicker(BuildContext context) async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: dateNow,
            firstDate: dateNow.subtract(const Duration(days: 25000)),
            lastDate: dateNow.add(const Duration(days: 30)),
            builder: (context, child) {
              return Theme(
                  data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme(
                    brightness: Brightness.light,
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    secondary: Colors.yellow,
                    onSecondary: Colors.yellowAccent,
                    error: Colors.red,
                    onError: Colors.orange,
                    background: Colors.blueAccent,
                    onBackground: Colors.blueGrey,
                    surface: Colors.blue,
                    onSurface: Colors.black26,
                  )),
                  child: child ?? const Text(""));
            }) ??
        selectedDate;

    setState(() {});
  }
}
