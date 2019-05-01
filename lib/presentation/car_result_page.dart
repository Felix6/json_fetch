import 'package:flutter/material.dart';


class CarResultPage extends StatefulWidget{
  @override
  _CarResultPageState createState() => _CarResultPageState();
}

class _CarResultPageState extends State<CarResultPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultados"),
        backgroundColor: Color.fromRGBO(172, 44, 58, 1),
      ),
      body: ListView.builder(
       // itemCount: ,
      ),
    );
  }
}