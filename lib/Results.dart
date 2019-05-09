import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_drawer/Networking.dart';
import 'package:material_drawer/buypage.dart';


class Results {
  bool success = true;
  String errorMessage = "";
  List<Payload> payload = new List();

  Results({this.success, this.errorMessage, this.payload});

  factory Results.fromJson(Map<String, dynamic> json){
    var list = json['payload'] as List;
    print(list); //returns List<dynamic>
    List<Payload> payLoadRes = list.map((i) => Payload.fromJson(i)).toList();

    return new Results(
        success: json["success"],
        errorMessage: json["errorMessage"].toString(),
        payload: payLoadRes
    );
  }

}

class Payload {
  String year;
  String stockNum;

  Payload({this.year, this.stockNum});

  factory Payload.fromJson(Map<String, dynamic> json){
    return new Payload(
        year: json["year"].toString(),
        stockNum: json["stockNum"].toString()
    );
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
        title: Text("Result"),
        backgroundColor: Color.fromRGBO(172, 44, 58, 1),
      ),
      body: FutureBuilder<Results>(
        future: Networking().getPartsResult(
            widget._makesSelection, widget._modelSelection, widget._fromYear, widget._toYear,
            widget._partsSelection),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            result = snapshot.data;

            return ListView.separated(
                itemBuilder: (context, position) {
                  final item = result.payload[position];
                  return  ListTile(
                    title: Text("Numero de pieza: " + item.stockNum.toString()),
                    subtitle: Text("Año: " + item.year.toString()),
                    leading:Image.network("https://junkerbernird.blob.core.windows.net/vehiclephotos/" + item.stockNum.toString() + "_FOTO1.jpg",height: 85, width: 85,),
                    trailing: RaisedButton(
                      child: Text("Ver mas",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      color: Color.fromRGBO(172, 44, 58, 1),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => BuyPartsRoute(
                            result.payload[position]
                          )
                        ));
                      },
                    )
                  );

                  // return Column(
                  //   children: <Widget>[
                  //     ListTile(
                  //       title: Text(item.year.toString()),
                  //       subtitle: Text(item.stockNum.toString()),
                  //     )
                  //     // Text(item.year.toString()),
                  //     // Text(item.stockNum.toString())
                  //   ],
                  // );
                },
                separatorBuilder: (context, position) => Divider(),
                itemCount: snapshot.data.payload.length);
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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