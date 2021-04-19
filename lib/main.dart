import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hypessage/resources/firebase_repository.dart';
import 'package:hypessage/screens/home_screen.dart';
import 'package:hypessage/screens/login_screen.dart';
import 'package:hypessage/screens/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseRepository _repository = FirebaseRepository();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hypessage',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/search_screen': (context) => SearchScreen()},
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xff017f04), primaryColorDark: Color(0xff017f04)),
      home: Scaffold(
        body: FutureBuilder(
          future: _repository.getCurrentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
