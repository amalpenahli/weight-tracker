import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx/screen/auth/login.dart';
import 'package:getx/screen/drawer_screen.dart';
import 'package:getx/screen/graphics.dart';
import 'package:getx/screen/history.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../views_model/controller.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({Key? key}) : super(key: key);

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  @override
  void initState() {
    super.initState();
  }

  DateTime _selecteddate1 = DateTime.now();
  TextEditingController note = TextEditingController();
  TextEditingController nameUpdate = TextEditingController();
  String _note = "qeyd əlavə et";

  var initialDate;
  final _firestore = FirebaseFirestore.instance;

  createInfo() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("tracker")
        .doc(Controller.selectedvalue.toString());

    Map<String, String> info = {
      "weight": Controller.selectedvalue.toString(),
      "month": DateFormat('EEE, MMM d,' 'yy').format(_selecteddate1),
      "userId":
          Provider.of<ProviderProfile>(context, listen: false).checkUser(),
    };
    documentReference.set(info).whenComplete(() => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const FlutterChart())),
          print(
              Provider.of<ProviderProfile>(context, listen: false).checkUser())
        });
  }

  void datePicker(BuildContext context) async {
    initialDate = DateTime.now();
    _selecteddate1 = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: initialDate.subtract(Duration(days: 365)),
            lastDate: initialDate.add(Duration(days: 30)),
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
        _selecteddate1;

    setState(() {});
  }

  final Controller controller = Get.put(Controller());
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Əlavə et"),
          centerTitle: true,
        ),
        drawer: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width / 1.5,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 36.0),
                  child: CircleAvatar(
                    minRadius: 30,
                    maxRadius: 55,
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          FirebaseAuth.instance.currentUser!.displayName
                              .toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("adını dəyiş"),
                                    content: TextField(
                                      controller: nameUpdate,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            FirebaseAuth.instance.currentUser!
                                                .updateDisplayName(
                                                    nameUpdate.text);
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          },
                          icon: const Icon(
                            FontAwesomeIcons.pencil,
                            size: 15,
                          ))
                    ],
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email.toString(),
                ),
                Text(
                    "${_selecteddate1.year - int.parse(FirebaseAuth.instance.currentUser!.photoURL.toString())}"),
                ElevatedButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: Text("Çıxış"))
              ],
            ),
          ),
        ),
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
                            DateFormat('EEE, MMM d,' 'yy')
                                .format(_selecteddate1),
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
                            controller: note,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  _note = note.text;
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
                  onPressed: () {
                    createInfo();

                    setState(() {});
                  },
                  child: Text(
                    "yadda saxla",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
