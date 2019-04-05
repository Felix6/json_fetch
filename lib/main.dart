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
  String _makesSelection;
  String _partsSelection;
  String _modelSelection;


  // these are GET requests  
  final String makesUrl = "https://admin.junkerbernird.com/api/vehicles/getmakes";
  final String partsUrl = "https://admin.junkerbernird.com/api/vehicles/getparts";


  // these are POST request
  final String modelsUrl = "https://admin.junkerbernird.com/api/vehicles/getmodels/";
  final String listUrl   = "https://admin.junkerbernird.com/api/vehicles/lists";

  List makesDataList = List(); 
  List partDataList = List();
  List modelDataList = List();

  Future<String> getModelData() async{
    print("getModelData-----------------------------------------------");
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());
    var makeId = "1";
    var modelRes = await http
        .post(Uri.encodeFull(modelsUrl + _makesSelection), 
          headers: {"content-type": "application/json", "token": base64.encode(utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))});
    var modelResBody = json.decode(modelRes.body);

      if(modelResBody['success'] == true){
        setState(() {
          modelDataList = modelResBody['payload'];
        });

        print(modelResBody);
        return "Sucess";
      }else{
        print("Fail boi");
        return "Failed";
      }
  }

  Future<String> getMakeData() async {
    print("getMakeData-----------------------------------------------");
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());
    var makeRes = await http
        .get(Uri.encodeFull(makesUrl), headers: {"content-type": "application/json", "token": base64.encode(utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))}); //, body: { "makeid": "1", "modelid": "1" });
    var makeResBody = json.decode(makeRes.body);

    if(makeResBody['success'] == true){
      setState(() {
        makesDataList = makeResBody['payload'];
      });

      print(makeResBody);

      return "Sucess";
    }else{
      return "Failed";
    }
  }

  Future<String> getPartsData() async {
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());

     var partsRes = await http
        .get(Uri.encodeFull(partsUrl), headers: {"content-type": "application/json", "token": base64.encode(utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))}); //, body: { "makeid": "1", "modelid": "1" });
    var partsResBody = json.decode(partsRes.body);

    if(partsResBody['success'] == true){
      setState(() {
        partDataList = partsResBody['payload'];
      });

      print(partsResBody);
      

      return "Sucess";
    }else{
      return "Failed";
    }
  }

  @override
  void initState() {
    super.initState();
    this.getMakeData();
    this.getPartsData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Junker Bernird"),
        backgroundColor: new Color.fromRGBO(172, 44, 58, 1),
      ),

      body: new Center(
        child: Column(
      
        children: <Widget>[
          
          Text("Marca",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton(
          hint: Text("Seleccione una marca"),
          items: makesDataList.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['value']),
              value: item['id'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _makesSelection = newVal;
            });
            this.getModelData();
          },
          value: _makesSelection,
        ),

        Text("Pieza",
         style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            ),
          ),
        DropdownButton(
          
          hint: Text("Seleccione una pieza"),

          items: partDataList.map((item){
            return new DropdownMenuItem(
              child: new Text(item['value']),
              value: item['id'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _partsSelection = newVal;
            });
          },
          value: _partsSelection,
        ),

        Text("Modelo",
         style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton(
            hint: Text("Seleccione un Modelo"),
            items: modelDataList.map((item) {
              return new DropdownMenuItem(
                child: new Text(item['value']),
                value: item['id'].toString(),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _modelSelection = newVal;
              });
            },
             value: _modelSelection,
          ),
        ],
      ),
      ),
    );
  }
}