import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hypessage/models/user.dart';
import 'package:hypessage/resources/firebase_repository.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  FirebaseRepository _repository = FirebaseRepository();

  List<User> userList;
  String query;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _repository.getCurrentUser().then((FirebaseUser user){
    _repository.fetchAllUsers(user).then((List<User> list){
      setState((){
        userList = list;
      }      );
    });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
