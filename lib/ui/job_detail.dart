import 'package:flutter/material.dart';
import 'package:quik_work/model/job.dart';
import 'package:quik_work/service/authentication.dart';
import 'package:quik_work/service/firebaseFirestoreService.dart';


class JobDetail extends StatefulWidget {

  final Job job;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  JobDetail(this.job, this.auth, this.userId, this.logoutCallback);

  @override
  _JobDetail createState() => _JobDetail();
}

class _JobDetail extends State<JobDetail> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();


  String status = 'Pending';
  String initial = '0';

//  void _NavigationToRequest(BuildContext context) async {
//    initial = '1';
//    db.createRequest(status, initial, widget.job.empId, widget.userId, widget.job.job_id);
//    await Navigator.push(
//      context,
//      MaterialPageRoute(
//          builder: (context) =>
//              RequestStatus(widget.auth, widget.userId, widget.logoutCallback)),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    final title = 'Job Details';

    Widget bigCircle = new Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
          color: Colors.orangeAccent,
          image: new DecorationImage(
              image: new AssetImage('assets/images/profile.jpg')),
          shape: BoxShape.circle,
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orangeAccent,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          widget.job.position,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(Icons.attach_money),
                            ),
                            Text(
                              '' +
                                  widget.job.salary +
                                  ' Per ' +
                                  widget.job.salaryType,
                              style: TextStyle(fontSize: 20.00),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(Icons.account_balance),
                            ),
                            Container(
                              child: Text(
                                'Watsons',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bigCircle
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment(-1.0, 0.0),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            color: Colors.orangeAccent,
            //color: Colors.orangeAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Job Description',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    widget.job.description,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment(-1.0, 0.0),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            color: Colors.orangeAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    'Job Requirement',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    widget.job.job_requirement,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: RaisedButton(
              //onPressed: () => _NavigationToRequest(context),
              child: const Text('Apply Job', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
