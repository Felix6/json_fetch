import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_drawer/Networking.dart';
import 'package:material_drawer/buypage.dart';
import 'package:material_drawer/contactPage.dart';

class Results {
  bool success = true;
  String errorMessage = "";
  List<Payload> payload = new List();

  Results({this.success, this.errorMessage, this.payload});

  factory Results.fromJson(Map<String, dynamic> json) {
    var list = json['payload'] as List;
    List<Payload> payLoadRes = list.map((i) => Payload.fromJson(i)).toList();

    return new Results(
        success: json["success"],
        errorMessage: json["errorMessage"].toString(),
        payload: payLoadRes);
  }
}

class Payload {
  String year;
  String stockNum;

  Payload({this.year, this.stockNum});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return new Payload(
        year: json["year"].toString(), stockNum: json["stockNum"].toString());
  }

  @override
  String toString() {
    return "Year: $year, StockNum: $stockNum";
  }
}

class ResultsRoute extends StatefulWidget {
  final String _makesSelection;
  final String _modelSelection;
  final int _fromYear;
  final int _toYear;
  final String _partsSelection;

  ResultsRoute(this._makesSelection, this._modelSelection, this._fromYear,
      this._toYear, this._partsSelection);

  @override
  _ResultsRouteState createState() => _ResultsRouteState();
}

class _ResultsRouteState extends State<ResultsRoute> {
  Results result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultados"),
        backgroundColor: Color.fromRGBO(172, 44, 58, 1),
      ),
      body: FutureBuilder<Results>(
        future: Networking().getPartsResult(
            widget._makesSelection,
            widget._modelSelection,
            widget._fromYear,
            widget._toYear,
            widget._partsSelection),
        builder: (context, snapshot) {
          // snapshot.hasData
          if (snapshot.hasData && snapshot.data.payload.length > 0) {
            result = snapshot.data;
            print(result.payload.length);
            return ListView.separated(
                itemBuilder: (context, position) {
                  final item = result.payload[position];
                  return ListTile(
                    title: Text("Número de pieza: " + item.stockNum.toString()),
                    subtitle: Text("Año: " + item.year.toString()),
                    leading: Image.network(
                      "https://junkerbernird.blob.core.windows.net/vehiclephotos/" +
                          item.stockNum.toString() +
                          "_FOTO1.jpg",
                      height: 85,
                      width: 85,
                    ),
                    trailing: RaisedButton(
                      child: Text(
                        "Ver más",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color.fromRGBO(172, 44, 58, 1),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BuyPartsRoute(result.payload[position])));
                      },
                    ),
                  );
                },
                separatorBuilder: (context, position) => Divider(),
                itemCount: snapshot.data.payload.length);
          } else if (snapshot.hasError) {
            return Center(child: Text("error loading"));
          } else if (snapshot.hasData && snapshot.data.payload.length == 0) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 70, 10, 5),
                    child: Center(
                      child: Image.asset(
                        "images/oops.png",
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                  Text(
                    "No se encontraron piezas.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  
                  Text(
                    "Para mas información, escríbenos",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
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
                            "Continuar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => (ContactWebView())));
                          },
                        ),
                      ),
                    ),
                  ),
                ]
              );
          }

          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[CircularProgressIndicator()],
              ),
            ),
          );
        },
      ),
    );
  }
}
