import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quik_work/model/request.dart';
import 'package:quik_work/service/authentication.dart';
import 'package:quik_work/service/firebaseFirestoreService.dart';

class RequestStatus extends StatefulWidget {
  RequestStatus(this.auth, this.userId, this.logoutCallback);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _RequestStatusState createState() => _RequestStatusState();
}

class _RequestStatusState extends State<RequestStatus> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  List<Request> itemReq;
  StreamSubscription<QuerySnapshot> reqSub;

  @override
  void initState() {
    super.initState();
    itemReq = new List();

    reqSub?.cancel();
    reqSub = db.getRequestList().listen((QuerySnapshot snapshot) {
      final List<Request> requests = snapshot.documents
          .map((documentSnapshot) => Request.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.itemReq = requests;
      });
    });
  }

  @override
  void dispose() {
    reqSub?.cancel();
    super.dispose();
  }

  List<Request> filter = new List();

  @override
  Widget build(BuildContext context) {
    final title = 'My Request';

//    for(int i = 0; i < itemReq.length; i++){
//      if(itemReq[i].empId == widget.userId){
//        if(filter.isEmpty){
//          filter.add(itemReq[i]);
//        }
//        else{
//          int c = 0;
//          for(int x = 0; x < filter.length; x++){
//            if(itemReq[i].id == filter[x].id){
//              c++;
//            }
//          }
//          if(c == 0){
//            filter.add(itemReq[i]);
//          }
//        }
//      }
//    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: filter != null
          ? ListView.builder(
              itemCount: itemReq.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Divider(height: 6.0),
                    ListTile(
                      title: Text('${itemReq[index].empId}'),
                      subtitle: Text(
                          'Request Status : ' + '${itemReq[index].req_status}'),
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
                      //onTap: () => _NavigationToDetail(context, filter[index]),
                    )
                  ],
                );
              },
            )
          : Text(' Request list is empty'),
    );
  }
}
