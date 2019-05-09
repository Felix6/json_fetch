import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class PartsSalePage extends StatefulWidget {
  @override
  _PartsSalePageState createState() => _PartsSalePageState();
}

class _PartsSalePageState extends State<PartsSalePage> {
  String _makesSelection;
  String _partsSelection;
  String _modelSelection;
  String _fromYear;
  String _toYear;

  // These are GET requests
  final String makesUrl = "https://admin.junkerbernird.com/api/vehicles/getmakes";
  final String partsUrl = "https://admin.junkerbernird.com/api/vehicles/getparts";

  // These are POST requests
  final String modelsUrl = "https://admin.junkerbernird.com/api/vehicles/getmodels/";
  final String listUrl = "https://admin.junkerbernird.com/api/vehicles/list/";

  List makesDataList = List();
  List partDataList = List();
  List modelDataList = List();
  List listResult = List();

  //, body: { "makeid": "1", "modelid": "1" });
  // _makesSelection + _modelSelection + _fromYear + _toYear+ _partsSelection
  Future<String> getPartsResult() async {
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());
  //  var makeId = "1";
    var partListRes =
    await http.post(Uri.encodeFull(listUrl), body: { "makeId":_makesSelection, "modelId":_modelSelection, "yearFrom":_fromYear, "yearTo":_toYear, "partId":_partsSelection}, headers: {
      "content-type": "application/json",
      "token": base64.encode(
          utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))
    });
    var partListResBody = json.decode(partListRes.body);

    if (partListResBody['success'] == true) {
      setState(() {
        listResult = partListResBody['payload'];
      });
    //  print(partListResBody);
      return "Success";
    } else {
      print("Failed");
      return "Failed";
    }
  }

  Future<String> getModelData() async {
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());
   // var makeId = "1";
    var modelRes =
        await http.post(Uri.encodeFull(modelsUrl + _makesSelection), headers: {
      "content-type": "application/json",
      "token": base64.encode(
          utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))
    });
    var modelResBody = json.decode(modelRes.body);

    if (modelResBody['success'] == true) {
      print("Model Data Success");
      setState(() {
        modelDataList = modelResBody['payload'];
      });

      //print(modelResBody);
      return "Sucess";
    } else {
      print("Failed");
      return "Failed";
    }
  }

  Future<String> getMakeData() async {
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());
    var makeRes = await http.get(Uri.encodeFull(makesUrl), headers: {
      "content-type": "application/json",
      "token": base64.encode(
          utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))
    }); //, body: { "makeid": "1", "modelid": "1" });
    var makeResBody = json.decode(makeRes.body);

    if (makeResBody['success'] == true) {
      print("Model Data Success");
      setState(() {
        makesDataList = makeResBody['payload'];
      });

    //  print(makeResBody);

      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<String> getPartsData() async {
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());

    var partsRes = await http.get(Uri.encodeFull(partsUrl), headers: {
      "content-type": "application/json",
      "token": base64.encode(
          utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))
    }); //, body: { "makeid": "1", "modelid": "1" });
    var partsResBody = json.decode(partsRes.body);

    if (partsResBody['success'] == true) {
      print("Get Parts Success");
      setState(() {
        partDataList = partsResBody['payload'];
      });

    //  print(partsResBody);

      return "Sucess";
    } else {
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Junker Bernird"),
        backgroundColor: new Color.fromRGBO(172, 44, 58, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// HEADER IMAGE
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Image.asset(
                "images/bernirdlogo.png",
                height: 100,
              ),
            ),

            /// MAKES DROPDOWN BUTTON
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey[250],
                  labelText: "Marca del auto",
                  labelStyle: TextStyle(
                      fontSize: 20.0, color: Color.fromRGBO(172, 44, 58, 1)),
                  border: OutlineInputBorder(),
                ),
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
            ),

            /// MODELS DROPDROP DOWN BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey[250],
                  labelText: "Modelo del Auto",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                      fontSize: 20.0, color: Color.fromRGBO(172, 44, 58, 1)),
                  border: OutlineInputBorder(),
                ),
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
            ),

            /// FROM YEAR TEXT FIELD
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey[250],
                  labelText: "Desde Año",
                  hintText: "Ej: 2005",
                  labelStyle: TextStyle(
                      color: Color.fromRGBO(172, 44, 58, 1), fontSize: 20.0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (newVal) {
                  if(newVal.length == 1) {
                    _fromYear = newVal;
                  }
                },
              ),
            ),

            /// TO YEAR TEXT FIELD
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey[250],
                    labelText: "Hasta Año",
                    hintText: "Ej: 2019",
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(172, 44, 58, 1), fontSize: 20.0),
                    border: OutlineInputBorder()
                ),
                onChanged: (newVal) {
                  if(newVal.length == 1) {
                    _toYear = newVal;
                  }
                },
              ),
            ),

            /// PARTS DROPDOWN BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey[250],
                  labelText: "Pieza del Auto",
                  labelStyle: TextStyle(
                      fontSize: 20.0, color: Color.fromRGBO(172, 44, 58, 1)),
                  border: OutlineInputBorder(),
                ),
                items: partDataList.map((item) {
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
            ),

            /// BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 75.0,
                  buttonColor: Color.fromRGBO(172, 44, 58, 1),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text(
                      "Buscar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    onPressed: () {
                     this.getPartsResult();

                     // Navigator.of(context).push(MaterialPageRoute(
                       //   builder: (BuildContext context) => AboutPage()));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
