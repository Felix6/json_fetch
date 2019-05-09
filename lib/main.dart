import 'package:flutter/material.dart';
import 'mainPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "Drawer in Flutter",
      debugShowCheckedModeBanner: false,
      home:  new MainPage(),
    );
  }
}


