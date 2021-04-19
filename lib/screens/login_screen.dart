import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hypessage/resources/firebase_repository.dart';
import 'package:hypessage/utils/universal_variables.dart';
import 'package:shimmer/shimmer.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _repository = FirebaseRepository();

  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                period: const Duration(seconds: 3),
                baseColor: Colors.grey,
                highlightColor: UniversalVariables.gradientColorEnd,
                child: Column(children: [
                  Image.asset('assets/images/logo.png'),
                  Text(
                    'HYPESSAGE',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              loginButton(),
            ],
          ),
        ),
        isLoginPressed
            ? Center(child: CircularProgressIndicator())
            : Container(),
      ]),
    );
  }

  Widget loginButton() {
    return MaterialButton(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.grey,
      textColor: Colors.white,
      highlightColor: UniversalVariables.gradientColorEnd,
      padding: EdgeInsets.all(10),
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      onPressed: () => performLogin(),
    );
  }

  void performLogin() {
    setState(() {
      isLoginPressed = true;
    });
    _repository.signIn().then((user) {
      print(user);
      if (user != null) {
        authenticateUser(user);
      } else {
        print('There was an error');
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false;
      });
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Get.to(HomeScreen());
        });
      } else {
        Get.to(HomeScreen());
      }
    });
  }
}
