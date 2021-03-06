import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:quik_work/model/job.dart';
import 'package:quik_work/service/firebaseFirestoreService.dart';

class JobSearch extends StatefulWidget {
  @override
  _JobSearch createState() => _JobSearch();
}

class _JobSearch extends State<JobSearch> {
//  var _list = [
//    'Cashier',
//    'Promoter',
//    'x',
//  ];

  List<Job> j;
  List _list = new List();
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> jobSub;

  @override
  void initState() {
    super.initState();
    j = new List();

    jobSub?.cancel();
    jobSub = db.getJobList().listen((QuerySnapshot snapshot) {
      final List<Job> jobs = snapshot.documents
          .map((documentSnapshot) => Job.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.j = jobs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < j.length; i++) {
      _list.add(j[i].position);
    }

    return Scaffold(
      body: new MaterialSearch<String>(
          placeholder: 'Search',
          //placeholder of the search bar text input
          //or

          results: _list
              .map((name) => new MaterialSearchResult<String>(
                    value: name,
                    text: name, //The value must be of type <String>
                  ))
              .toList(),

          //optional. default filter will look like this:

          //optional

          //callback when some value is selected, optional.

          //callback when the value is submitted, optional.
          onSelect: (dynamic value) => Navigator.of(context).pop(value)),
    );
  }
}
