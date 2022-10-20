import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _firebaseAuth;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController ageController;
  late final TextEditingController nameController;
  late final CollectionReference usersCollection;
  late DateTime selectedDate;
  late final DateTime dateNow;
  late final User currentUser;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    usersCollection = _firestore.collection("users");
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    ageController = TextEditingController();
    dateNow = DateTime.now();
    selectedDate = dateNow;
     currentUser = _firebaseAuth.currentUser!;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    ageController.dispose();
  }

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
            const SizedBox(height: 20),
            GestureDetector(
              onTap: (() {
                datePicker(context);
              }),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
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
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              const Text("Doğum günü"),
                              const SizedBox(width: 60),
                              Text(
                                DateFormat('EEE, MMM d,' 'yy')
                                    .format(selectedDate),
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
            const SizedBox(height: 20),
            TextFieldContainer(
              text: "Email",
              controller: emailController,
              icon: FontAwesomeIcons.user,
            ),
            const SizedBox(height: 20),
            TextFieldContainer(
              text: "Password",
              controller: passwordController,
              icon: FontAwesomeIcons.key,
            ),
            const SizedBox(height: 40),
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
                    primary: Colors.lightBlueAccent,
                    onPrimary: Colors.red,
                    secondary: Colors.yellow,
                    onSecondary: Colors.yellowAccent,
                    error: Colors.red,
                    onError: Colors.orange,
                    background: Colors.red,
                    onBackground: Colors.blueGrey,
                    surface: Colors.blue,
                    onSurface: Colors.black26,
                  )),
                  child: child ?? const Text(""));
            }) ??
        selectedDate;
        setState(() {
          
        });
  }

  Future signUp() async {
     {
      if(emailController.text == currentUser.email){
        const snackBar = SnackBar(
        backgroundColor: Colors.orange,
        content: Text('email artiq movcuddur'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((userCredential) async {
        addToFirestore(userCredential.user!);
      });
    } 
    Get.to(() => LoginScreen());
  }

  addToFirestore(User user) async {
    Map<String, dynamic> addedUserInfo = <String, dynamic>{};
    addedUserInfo['name'] = nameController.text;
    addedUserInfo['email'] = emailController.text;
    addedUserInfo['userId'] = user.uid;
    addedUserInfo['age'] = dateNow.year - selectedDate.year;
    addedUserInfo['createdAt'] = FieldValue.serverTimestamp();
    await usersCollection.doc(user.uid).set(addedUserInfo, SetOptions(merge: true));
  }
}
