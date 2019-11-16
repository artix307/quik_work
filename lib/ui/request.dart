import 'package:flutter/material.dart';
import 'package:quik_work/service/authentication.dart';

class Request extends StatefulWidget {
  Request(this.auth, this.userId, this.logoutCallback);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    final title = 'Request';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
