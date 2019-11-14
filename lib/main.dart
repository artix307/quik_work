import 'package:flutter/material.dart';
import 'package:quik_work/service/authentication.dart';
import 'package:quik_work/ui/root_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Returning Data',

        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.deepOrangeAccent,
          //Changing this will change the color of the TabBar
          accentColor: Colors.deepOrange,
        ),
        //home: HomeOpen(),);
        home: new RootPage(auth: new Auth()));

  }
}