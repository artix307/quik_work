import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quik_work/model/job.dart';
import 'package:quik_work/service/service_job.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobDetail extends StatefulWidget {
  //const JobDetail(Job job, {Key key}) : super(key: key);

  final Job job;

  JobDetail(this.job);

  @override
  _JobDetail createState() => _JobDetail();
}

class _JobDetail extends State<JobDetail> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Text('hi'),
        Text('World'),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final title = 'Job Details';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          titleSection,
        ],
      ),
    );
  }
}
