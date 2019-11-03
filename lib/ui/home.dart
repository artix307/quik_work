import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quik_work/service/service_job.dart';
import 'package:quik_work/model/job.dart';
import 'package:quik_work/ui/bookmark.dart';
import 'package:quik_work/ui/job_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:quik_work/service/authentication.dart';
import 'package:quik_work/ui/profile.dart';

class Home extends StatefulWidget {
  Home({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          // The BuildContext must be from one of the Scaffold's children.
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              bottomNavigationBar: Container(
                child: Material(
                  color: Colors.white,
                  child: new TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.card_travel),
                        text: 'Job',
                      ),
                      Tab(icon: Icon(Icons.bookmark),
                          text: 'Bookmark'),
                      Tab(icon: Icon(Icons.face),
                          text: 'Profile'),
                    ],
                    labelColor: Colors.deepOrangeAccent,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.all(5.0),
                    indicatorColor: Colors.deepOrangeAccent,
                  ),
                ),
              ),
              body: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  JobList(),
                  Bookmark(),
                  Profile(widget.auth, widget.userId, widget.logoutCallback),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
