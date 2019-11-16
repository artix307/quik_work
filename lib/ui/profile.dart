import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quik_work/model/user.dart';
import 'package:quik_work/service/authentication.dart';
import 'package:quik_work/service/firebaseFirestoreService.dart';

class Profile extends StatefulWidget {
  Profile(this.auth, this.userId, this.logoutCallback);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  List<User> items;
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  StreamSubscription<QuerySnapshot> userSub;

  @override
  void initState() {
    super.initState();

    items = new List();

    userSub?.cancel();
    userSub = db.getUserList().listen((QuerySnapshot snapshot) {
      final List<User> users = snapshot.documents
          .map((documentSnapshot) => User.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = users;
      });
    });
  }

  User data;

  @override
  Widget build(BuildContext context) {
    final title = 'Profile';
    print(widget.userId);
    for (int i = 0; i < items.length; i++) {
      if (items[i].user_id == widget.userId) {
        data = items[i];
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body: data == null
          ? Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                        color: Colors.orangeAccent,
                        image: new DecorationImage(
                            image: new AssetImage('assets/images/profile.jpg')),
                        shape: BoxShape.circle,
                      )),
                  Text(''),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                        color: Colors.orangeAccent,
                        image: new DecorationImage(
                            image: new AssetImage('assets/images/profile.jpg')),
                        shape: BoxShape.circle,
                      )),
                  Text(data.user_email),
                ],
              ),
            ),
    );
  } //
}
