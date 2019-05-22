import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about.dart';
import 'carSaleSplash.dart';
import 'contactPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'legalPge.dart';
import 'package:material_drawer/Results.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_drawer/presentation/custom_icons_icons.dart';

class MainPageState extends State<MainPage> {
  var title = ''; // title is mutable property
  String _makesSelection;
  String _partsSelection;
  String _modelSelection;
  int _fromYear;
  int _toYear;

  // These are GET requests
  final String makesUrl =
      "https://admin.junkerbernird.com/api/vehicles/getmakes";
  final String partsUrl =
      "https://admin.junkerbernird.com/api/vehicles/getparts";

  // These are POST requests
  final String modelsUrl =
      "https://admin.junkerbernird.com/api/vehicles/getmodels/";
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
                "¿Quiénes Somos?",
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
                Icons.attach_money,
                size: 35.0,
                color: Colors.green,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => (CarSaleSplash())));
              },
              title: Text(
                "Véndenos tu Auto",
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
                "Nuestra Ubicación",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                _launchMap();
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
                "Llámanos",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
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
                "Escríbenos",
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
                "Aviso Legal",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LegalPage()));
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: IconButton(
                            icon: Icon(
                              CustomIcons.facebook_official,
                              size: 45,
                              color: Color.fromRGBO(59, 89, 152, 1),
                            ),
                            onPressed: () {
                              _launchFacebook();
                            },
                          )),
                      SizedBox(
                        width: 35,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: IconButton(
                            icon: Icon(
                              CustomIcons.youtube_play,
                              size: 50,
                              color: Color.fromRGBO(204, 24, 30, 1),
                            ),
                            onPressed: () {
                              _launchYoutube();
                            },
                          )),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _launchFacebook() async {
    const facebookUrl = "https://www.facebook.com/SuperJunkerBernird/";
    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl, forceWebView: true);
    } else {
      throw "Could not Call $facebookUrl";
    }
  }

  _launchYoutube() async {
    const videoUrl = "https://www.youtube.com/playlist?list=PLoeD6gJpKNV2poKUnL-wSzNUqyDw3E9AF";
    if (await canLaunch(videoUrl)) {
      await launch(videoUrl);
    } else {
      throw "Could not launch $videoUrl";
    }
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

  _launchMap() async {
    const mapUrl = "https://goo.gl/maps/obHa61Xim8KyjEU18";
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw "Could not Call $mapUrl";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Super Junker Bernird",
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
                    Image.asset("images/about_header2.png"),
                    Image.network(
                        "http://www.bmstudiopr.com/jbapp/promo/promo2.png"),
                    Image.network(
                        "http://www.bmstudiopr.com/jbapp/promo/promo3.png")
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
                    labelText: "Marca del Auto",
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
                    if (newVal.length > 1) {
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
                          color: Color.fromRGBO(172, 44, 58, 1),
                          fontSize: 20.0),
                      border: OutlineInputBorder()),
                  onChanged: (newVal) {
                    if (newVal.length > 1) {
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => ResultsRoute(
                                _makesSelection,
                                _modelSelection,
                                _fromYear,
                                _toYear,
                                _partsSelection)));
                      },
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Image.network(
                      "http://www.bmstudiopr.com/jbapp/bottompromo/bigpromo.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Image.network(
                      "http://www.bmstudiopr.com/jbapp/bottompromo/mediumpromo.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Image.network(
                      "http://www.bmstudiopr.com/jbapp/bottompromo/smallpromo.png"),
                ),
              )
            ]),
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
