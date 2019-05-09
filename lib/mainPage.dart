import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about.dart';
import 'mapsPage.dart';
import 'carSaleSplash.dart';
import 'contactPage.dart';
import 'partsSalePage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'legalPge.dart';
import 'package:material_drawer/Results.dart';
import 'package:flutter/cupertino.dart';

class MainPageState extends State<MainPage> {
  var title = ''; // title is mutable property
  String _makesSelection;
  String _partsSelection;
  String _modelSelection;
  int _fromYear;
  int _toYear;

  // These are GET requests
  final String makesUrl = "https://admin.junkerbernird.com/api/vehicles/getmakes";
  final String partsUrl = "https://admin.junkerbernird.com/api/vehicles/getparts";

  // These are POST requests
  final String modelsUrl = "https://admin.junkerbernird.com/api/vehicles/getmodels/";
  final String listUrl = "https://admin.junkerbernird.com/api/vehicles/list/";

  List makesDataList = List();
  List partDataList = List();
  List modelDataList = List();
  
  
  Future<String> getModelData() async {
  //  print("getModelData-----------------------------------------------");
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
      setState(() {
        modelDataList = modelResBody['payload'];
      });
      print("Model Data Success");
      return "Sucess";
    } else {
      print("Failed");
      return "Failed";
    }
  }

  Future<String> getMakeData() async {
  //  print("getMakeData-----------------------------------------------");
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());
    var makeRes = await http.get(Uri.encodeFull(makesUrl), headers: {
      "content-type": "application/json",
      "token": base64.encode(
          utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))
    }); //, body: { "makeid": "1", "modelid": "1" });
    var makeResBody = json.decode(makeRes.body);

    if (makeResBody['success'] == true) {
      setState(() {
        makesDataList = makeResBody['payload'];
      });

      print("Makes Data Success");

      return "Sucess";
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
    });
    var partsResBody = json.decode(partsRes.body);

    if (partsResBody['success'] == true) {
      setState(() {
        partDataList = partsResBody['payload'];
      });

      print("Parts Data Success");

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

  Drawer _buildDrawer(context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          DrawerHeader(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Card(
                  child: Image.asset(
                    'images/bernirdlogo.png',
                    height: 115.0,
                  ),
                  // Text('Super Junker Bernird',
                  // style: TextStyle(
                  //   color: Colors.black,
                  //   fontWeight: FontWeight.bold
                  // ),),
                  elevation: 10.0,
                ),
              ],
            ),
          )),

          Card(
            child: new ListTile(
              leading: new Icon(
                Icons.people,
                size: 35.0,
              ),
              title: Text(
                'Quienes Somos',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AboutPage()));
              },
            ),
          ),
          Card(
            child: new ListTile(
              leading: new Icon(
                Icons.directions_car,
                size: 35.0,
                color: Colors.amber,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PartsSalePage()));

                //_launchBUY();
              },
              title: Text(
                "Comprar Piezas",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),

          Card(
            child: new ListTile(
              leading: new Icon(
                Icons.attach_money,
                size: 35.0,
                color: Colors.green,
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => CarSalePage(),
                //   ),
                // );
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => (CarSaleSplash())));
              },
              title: Text(
                "Vendenos tu auto",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),

          Card(
            child: new ListTile(
              leading: new Icon(Icons.room, size: 35.0, color: Colors.red),
              title: Text(
                'Como llegar',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MapsPage()));
              },
            ),
          ),

          Card(
            child: new ListTile(
              leading:
                  new Icon(Icons.phone_in_talk, size: 35.0, color: Colors.blue),
              onTap: () {
                _launchCALL();
              },
              title: Text(
                "Llamanos",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),

          // Card(
          //   child: ListTile(
          //     leading: Icon(CustomIcons.facebook_official, size: 35.0, color: Color.fromRGBO(59, 89, 152, 1),),
          //     onTap: () {
          //       Navigator.of(context).pop();
          //       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => FacebookWebView()));
          //     },
          //     title: Text("Visita nuestra pagina",
          //       style: TextStyle(
          //         fontSize: 20,
          //       ),
          //     ),
          //   ),
          // ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.mail,
                size: 35.0,
                color: Colors.deepOrange,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ContactWebView()));
              },
              title: Text(
                "Escribenos",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),

          Card(
            child: new ListTile(
              leading: new Icon(Icons.filter, size: 35.0, color: Colors.red),
              title: Text(
                'Legal',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LegalPage()));
              },
            ),
          ),
          // Image.asset("images/drawerfooter.jpg",
          //   height: 160.0)
        ],
      ),
    );
  }

  // this function is responsible for calling the dialer
  // when taping the listTile for phone calls
  _launchCALL() async {
    const url = "tel:7878471686";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not Call $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Junker Bernird",
        ),
        backgroundColor: new Color.fromRGBO(172, 44, 58, 1), //#aa2c3a
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
          child: CarouselSlider(
            height: 193.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              items: <Widget>[
                Image.asset("images/headernegocio.jpeg"),
                Image.asset("images/headerempleados.jpeg"),
                Image.asset("images/headerllamanos.jpeg")
                ],
              ),
            ),
            
            /// MAKES DROPDOWN BUTTON
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                  if(newVal.length > 1) {
                    _fromYear = int.parse(newVal);
                  }
                },
              ),
            ),

            /// TO YEAR TEXT FIELD
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                  if(newVal.length > 1) {
                    _toYear = int.parse(newVal);
                  }
                },
              ),
            ),

            /// PARTS DROPDOWN BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                    // this.getPartsResult();

                     Navigator.of(context).push(MaterialPageRoute(
                       builder: (BuildContext context) => ResultsRoute(
                         _makesSelection,
                         _modelSelection,
                         _fromYear,
                         _toYear,
                         _partsSelection
                       )
                     ));
                    },
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}
