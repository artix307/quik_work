import 'package:flutter/material.dart';

//access database
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quik_work/service/service_job.dart';
import 'package:quik_work/model/job.dart';

//page
//import 'package:quik_work/ui/job_update.dart';
import 'package:quik_work/ui/job_search.dart';

import 'job_details.dart';

class JobList extends StatefulWidget {
  const JobList({Key key}) : super(key: key);

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<Job> items;
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  StreamSubscription<QuerySnapshot> jobSub;

  @override
  void initState() {
    super.initState();

    items = new List();

    jobSub?.cancel();
    jobSub = db.getJobList().listen((QuerySnapshot snapshot) {
      final List<Job> jobs = snapshot.documents
          .map((documentSnapshot) => Job.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = jobs;
      });
    });
  }

  @override
  void dispose() {
    jobSub?.cancel();
    super.dispose();
  }

  void _NavigationToDetail(BuildContext context, Job job) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => JobDetail(Job(null, '', '', '', '', ''))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Job List';

    return Scaffold(
      appBar: AppBar(title: Text(title), actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.search),
          //onPressed: _searchPressed,
        )
      ]),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Divider(height: 6.0),
              ListTile(
                title: Text('${items[index].position}'),
                subtitle: Text('${items[index].salary}'),
                onTap: () => _NavigationToDetail(context, items[index]),
              )
            ],
          );
        },
      ),
    );
  }
}
