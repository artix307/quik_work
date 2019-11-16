import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quik_work/model/job.dart';
import 'package:quik_work/service/authentication.dart';
import 'package:quik_work/service/firebaseFirestoreService.dart';
import 'package:quik_work/ui/job_detail.dart';
import 'package:quik_work/ui/job_search.dart';

class JobList extends StatefulWidget {
  JobList(this.auth, this.userId, this.logoutCallback);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

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
          builder: (context) => JobDetail(
              job, widget.auth, widget.userId, widget.logoutCallback)),
    );
  }

  void _NavigationToSearch(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            //builder: (context) => SearchPage()
            ));
  }

  List<Job> search;

  @override
  Widget build(BuildContext context) {
    final title = 'Job List';

    return Scaffold(
      appBar: AppBar(title: Text(title), actions: <Widget>[
        new IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () async {
              search = new List();
              String save =
                  await Navigator.of(context).push(new PageRouteBuilder<String>(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) {
                  return new JobSearch();
                },
              ));
              if (save != null) {
                print(save);

                for (int i = 0; i < items.length; i++) {
                  if (items[i].position == save) {
                    search.add(items[i]);
                  }
                }
                print(search);
                setState(() => build(context));
              }
            })
      ]),
      // ignore: unrelated_type_equality_checks
      body: search == null
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Divider(height: 6.0),
                    ListTile(
                      title: Text('${items[index].position}'),
                      subtitle: Text('${items[index].salary}'),
                      leading: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            color: Colors.orangeAccent,
                            image: new DecorationImage(
                                image: new NetworkImage(
                                    'https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/0019/2920/brand.gif?itok=-WG4-Sgc')),
                            shape: BoxShape.circle,
                          )),
                      onTap: () => _NavigationToDetail(context, items[index]),
                    )
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: search.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Divider(height: 6.0),
                    ListTile(
                      title: Text('${search[index].position}'),
                      subtitle: Text('${search[index].salary}'),
                      leading: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            color: Colors.orangeAccent,
                            image: new DecorationImage(
                                image: new NetworkImage(
                                    'https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/0019/2920/brand.gif?itok=-WG4-Sgc')),
                            shape: BoxShape.circle,
                          )),
                      onTap: () => _NavigationToDetail(context, search[index]),
                    )
                  ],
                );
              },
            ),
    );
  }
}
