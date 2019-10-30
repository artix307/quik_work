import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quik_work/service/service_job.dart';
import 'package:quik_work/model/job.dart';
import 'package:quik_work/ui/job_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:quik_work/service/authentication.dart';

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
                  color: Colors.grey,
                  child: new TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.chat),
                        text: 'jnjn',
                      ),
                      Tab(icon: Icon(Icons.calendar_today)),
                      Tab(icon: Icon(Icons.bubble_chart)),
                    ],
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.black12,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.all(5.0),
                    indicatorColor: Colors.grey,
                  ),
                ),
              ),
              body: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  JobList(),
                  Icon(Icons.chat),
                  Icon(Icons.bubble_chart),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
