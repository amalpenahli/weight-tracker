import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx/screen/graphics.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../provider/provider.dart';
import '../../utils/styles.dart';
import '../../widgets/text_form.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  final FirebaseFirestore auth = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  

DateTime _selecteddate = DateTime.now();
  var initialDate;
void datePicker(BuildContext context) async {
    initialDate = DateTime.now();
    _selecteddate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: initialDate.subtract(Duration(days: 25000)),
            lastDate: initialDate.add(Duration(days: 30)),
            builder: (context, child) {
              return Theme(
                  data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme(
                    brightness: Brightness.light,
                    primary: Colors.lightBlueAccent,
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
        _selecteddate;
setState(() {
  print(_selecteddate.year);
});
  
  }
// createProfile() {
//     DocumentReference documentReference = FirebaseFirestore.instance
//         .collection("users")
//         .doc(nameController.text);

//     Map<String, String> infoProfile = {
//       "name": nameController.text,
//       "age": ageController.text,
//       "email":emailController.text,
//       "password": passwordController.text,
//       "userId":
//           Provider.of<ProviderProfile>(context, listen: false).checkUser(),

//     };
//     documentReference.set(infoProfile).whenComplete(() => {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => LoginScreen(

//                   ))),
//           print(Provider.of<ProviderProfile>(context, listen: false).checkUser())
//         });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  "assets/images/lose-weight2.jpeg",
                ),
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Register",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldContainer(
              text: "Name",
              controller: nameController,
              icon: FontAwesomeIcons.user,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: (() {
                  datePicker(context);
                }),
                child: Card(
                  
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Icon(
                          FontAwesomeIcons.calendar,
                          size: 20,
                          color: Styles.appColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Row(
                              children: [
                                Text("Doğum günü"),
                                SizedBox(width: 60,),
                                Text(
                                
                                  DateFormat('EEE, MMM d,' 'yy')
                                      .format(_selecteddate),
                                  
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            TextFieldContainer(
              text: "Email",
              controller: emailController,
              icon: FontAwesomeIcons.user,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldContainer(
              text: "Password",
              controller: passwordController,
              icon: FontAwesomeIcons.key,
            ),
            const SizedBox(
              height: 40,
            ),
            Ink(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 13.4,
                decoration: BoxDecoration(
                    color: Styles.appColor,
                    borderRadius: BorderRadius.circular(25)),
                child: ElevatedButton(
                  // borderRadius: BorderRadius.circular(25),
                  child: const Center(
                      child: Text(
                    "Sign up",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                  onPressed: () {
                    Provider.of<ProviderProfile>(context, listen: false)
                        .nameUser(nameController.text);

                    setState(() {
                      //print(Provider.of<ProviderProfile>(context).a);
                      signUp();
                    });
                  },
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Already have an account?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 20)),
                TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: const Text(" Sign in",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)))
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // Future signUpp() async {
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailController.text,
  //         password: passwordController.text);

  //   } on FirebaseAuthException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       backgroundColor: Colors.red,
  //       content: Text("email movcuddur"),
  //     ));
  //   }
  // }

  Future signUp() async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => const Center(
    //           child: CircularProgressIndicator(),
    //         ));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) => {
                value.user!.updateDisplayName(nameController.text),
                value.user!.updatePhotoURL(_selecteddate.year.toString()),
              })
          .whenComplete(() {
        addtoFire();
        Get.to(LoginScreen());
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      ));
    }
    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  addtoFire() async {
    Map<String, dynamic> _addedUser = <String, dynamic>{};
    _addedUser['name'] = FirebaseAuth.instance.currentUser!.displayName;
    _addedUser['email'] = FirebaseAuth.instance.currentUser!.email;
    _addedUser['userUid'] = FirebaseAuth.instance.currentUser!.uid;
    _addedUser['currentYear'] = FirebaseAuth.instance.currentUser!.photoURL;
   //_addedUser['age'] =  FirebaseAuth.instance.currentUser!.age;
    _addedUser['createdAt'] = FieldValue.serverTimestamp();
    await firestore.collection('users').add(_addedUser);
  }
     
}
