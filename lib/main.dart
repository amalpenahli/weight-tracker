import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx/provider/provider.dart';

import 'package:getx/screen/auth/login.dart';
import 'package:getx/screen/auth/register.dart';
import 'package:getx/screen/home_screen.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.red));
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderProfile())
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: Colors.black),
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
              future: _initialization,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("sehv"),
                  );
                } else if (snapshot.hasData) {
                  return RegisterScreen();
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })

          //HomeScreen(),
          ),
    );
  }
}
