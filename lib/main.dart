import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
      title: "Hospital Management",
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _mySelection;

  final String url = "https://admin.junkerbernird.com/api/vehicles/getmakes";

  List data = List(); //edited line

  Future<String> getSWData() async {
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());
    var res = await http
        .get(Uri.encodeFull(url), headers: {"content-type": "application/json", "token": base64.encode(utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))});
    var resBody = json.decode(res.body);

    if(resBody['success'] == true){
      setState(() {
        data = resBody['payload'];
      });

      print(resBody);

      return "Sucess";
    }else{
      return "Failed";
    }
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Hospital Management"),
      ),
      body: new Center(
        child: new DropdownButton(
          items: data.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['value']),
              value: item['id'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _mySelection = newVal;
            });
          },
          value: _mySelection,
        ),
      ),
    );
  }
}