import 'package:flutter/material.dart';
import 'package:quik_work/service/authentication.dart';

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

  @override
  Widget build(BuildContext context) {
    final title = 'Profile';

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
    );
  }
}
