import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:getx/data/image_storage.dart';
import 'package:getx/screen/auth/login.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../constants/constants.dart';
import '../widgets/drawer_card.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _firebaseAuth;
  late final User currentUser;
  late final CollectionReference usersCollection;

  late final TextEditingController nameController;

  @override
  void initState() {
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    currentUser = _firebaseAuth.currentUser!;
    usersCollection = _firestore.collection('users');

    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
     decoration: GradientColor.decoration,
      child: StreamBuilder<DocumentSnapshot>(
          stream: usersCollection.doc(currentUser.uid).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  decoration: GradientColor.decoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(() => LoginScreen());
                              },
                              icon: const Icon(
                                Icons.exit_to_app,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                       Padding(
                          padding: EdgeInsets.only(top: 36.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,

                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),

                               child: data['image']==null? Image.asset('assets/images/man.png'):Image.asset(data['image'])
                        

                               )
                          )),
                      ElevatedButton(
                          onPressed: () async {
                            final results = await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                                type: FileType.custom,
                                allowedExtensions: ['png', 'jpg']);

                            if (results == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("no file")));
                              return null;
                            }
                            final path = results.files.single.path!;
                            final fileName = results.files.single.name;

                            DocumentReference documentReference =
                                usersCollection.doc(currentUser.uid);
                            Map<String, String> profileImage = {"image": path};
                            documentReference
                                .set(profileImage, SetOptions(merge: true))
                                .whenComplete(() => {snackBarContent1()});
                            // storage
                            //     .uploadFile(path, fileName)
                            //     .then((value) => print("done"));
                          },
                          child: const Text("upload image")),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['name'],
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
                                      controller: nameController,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            DocumentReference
                                                documentReference =
                                                usersCollection
                                                    .doc(currentUser.uid);
                                            Map<String, String> updateName = {
                                              "name": nameController.text
                                            };
                                            documentReference
                                                .set(updateName,
                                                    SetOptions(merge: true))
                                                .whenComplete(
                                                    () => {snackBarContent()});
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
                ContainerDrawer(
                  title: "Email ünvan",
                  subtitle: currentUser.email!,
                  decoration: GradientColor.decoration,
                 
                ),
                ElevatedButton(onPressed: (){}, child: Text("emaili tesdiqle")),
                const SizedBox(height: 10),
                ContainerDrawer(
                  title: "Yaşınız",
                  subtitle: data['age'].toString(),
                  decoration: GradientColor.decoration,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                
                ElevatedButton(onPressed: (){

                  setState(() {
                   
                  });
                }, child: Text("duzelisler"))
              ],
              
            );
          }),
    );
  }

  snackBarContent() {
    var snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content

      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        color: Colors.green,
        title: 'Uğurla dəyişildi',
        message: "Adınız dəyişildi",

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  snackBarContent1() {
    var snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content

      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        color: Colors.green,
        title: 'Sekil yuklendi',
        message: "",

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
