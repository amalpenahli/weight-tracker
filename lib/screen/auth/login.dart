import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx/screen/add_record.dart';
import 'package:getx/screen/auth/register.dart';
import 'package:getx/screen/graphics.dart';
import 'package:getx/screen/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../provider/provider.dart';
import '../../utils/styles.dart';
import '../../widgets/animated_login_register_button.dart';
import '../../widgets/text_form.dart';

enum ButtonState { init, loading }

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
   {
 
  
  late final FirebaseFirestore firestore;
  late final FirebaseAuth _firebaseAuth;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final Future<FirebaseApp> initialization;
  late final User? currentUser;

  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  @override
  void initState() {
    if (Provider.of<ProviderProfile>(context, listen: false).isLoggedIn ==
        true) {
      getCurrentUser();
      
    }
    firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    emailController = TextEditingController();
    passwordController = TextEditingController();
    initialization = Firebase.initializeApp();
    currentUser = _firebaseAuth.currentUser;

    
super.initState();
   
  }

  void dispose() {
   
    super.dispose();
  }

  void getCurrentUser() {
    setState(() {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        Provider.of<ProviderProfile>(context, listen: false).userId =
            FirebaseAuth.instance.currentUser!.uid;
      }
      // Provider.of<ProviderProfile>(context, listen: false).userId =
      //     FirebaseAuth.instance.currentUser!.uid;
      //     print(FirebaseAuth.instance.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final isStreched = isAnimating || state == ButtonState.init;
    final loading = state == ButtonState.loading;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Hero(
              transitionOnUserGestures: true,
              
              tag: "tag", 
              child: Image.asset("assets/images/lose-weight.jpeg"),
              
              )
           ,

          
          
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(32),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                width: state == ButtonState.init ? width : 70,
                onEnd: () => setState(() => isAnimating = !isAnimating),
                height: 70,
                child: isStreched ? buildButton() : buildSmallButton(loading),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 20)),
                TextButton(
                    onPressed: () {
                      setState(() {
                        Get.to(RegisterScreen());
                      });
                    },
                    child: const Text(" Create",
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

  Future signIn() async {
    Provider.of<ProviderProfile>(context, listen: false).isLogged();

    if (emailController.text == "" || passwordController.text == "") {
      const snackBar = SnackBar(
        backgroundColor: Colors.orange,
        content: Text('xanalar boş ola bilməz'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (!emailController.text.contains("@")) {
      const snackBar = SnackBar(
        backgroundColor: Colors.orange,
        content: Text('email unvani duz yazin'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (emailController.text != currentUser!.email) {
      const snackBar = SnackBar(
        backgroundColor: Colors.orange,
        content: Text('email movcud deyil'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
        .then((value) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            ));
    ;
    // } on FirebaseAuthException catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       backgroundColor: Colors.red,
    //       content: Text(e.toString()),
    //     ),
    //   );
    // }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Widget buildButton() => ElevatedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
            shape: const StadiumBorder(),
            side: const BorderSide(width: 2, color: Colors.lightBlueAccent)),
        child: const Text(
          'submit',
          style: TextStyle(
              fontSize: 24,
              color: Colors.indigo,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600),
        ),
        onPressed: () async {
          signIn();
          setState(() => state = ButtonState.loading);
          await Future.delayed(const Duration(seconds: 3));

          setState(() => state = ButtonState.init);
        },
      );
}

Widget buildSmallButton(bool loading) {
  final color = Colors.lightBlueAccent;
  return Container(
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    child: const Center(
      child: CircularProgressIndicator(color: Colors.white),
    ),
  );
}
