import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_drawer/Networking.dart';
import 'package:material_drawer/Results.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarPayload {
  bool success = true;
  String errorMessage = "";
  List<Parts> carDetails =  List();
  List<Parts> carParsts = List();


  CarPayload({this.success, this.errorMessage, this.carDetails, this.carParsts});

  factory CarPayload.fromJson(Map<String, dynamic> json){
    // Contains details about the car
    var detailslist = json["payload"] as List;
    print(detailslist);
    // Contains available parts for the car
    var partslist = json["payload"]["parts"] as List;
    
    
    List<Parts> detailsRes = detailslist.map((i) => Parts.fromJson(i)).toList();
    List<Parts> partsRes = partslist.map((i) => Parts.fromJson(i)).toList();
   
    return new CarPayload(
      success: json["success"],
      errorMessage: json["errorMessage"].toString(),
      carDetails: detailsRes,
      carParsts: partsRes,
    );
  }
}

class Parts {
  String year;
  String stockNum;
  String vin;
  String make;
  String model;
  String trim;
  String engine;
  String transmission;
  String color;
  List<String> parts;
  
  
  Parts({this.year,this.stockNum,this.vin,this.make,this.model,this.trim,this.engine,this.transmission,this.color,this.parts});

  factory Parts.fromJson(Map<String, dynamic> json){
    var partsFromJson = json["parts"];
    List<String> parts = List<String>.from(partsFromJson);
    return Parts(
      
      
      year: json["year"].toString(),
      stockNum: json["stockNum"].toString(),
      vin: json["vin"].toString(),
      make: json["make"].toString(),
      model: json["model"].toString(),
      trim: json["trim"].toString(),
      engine: json["engine"].toString(),
      transmission: json["transmission"].toString(),
      color: json["color"].toString(),
      parts: parts

    );
  }
}





class BuyPartsRoute extends StatefulWidget {
  final Payload item;

  BuyPartsRoute(this.item);
  @override
  _BuyPartsRouteState createState() => _BuyPartsRouteState();
}

class _BuyPartsRouteState extends State<BuyPartsRoute> {
  CarPayload details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comprar Pieza"),
        backgroundColor: Color.fromRGBO(172, 44, 58, 1),        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CarouselSlider(
                height: 200.0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                
                items:<Widget>[
                  Image.network("https://junkerbernird.blob.core.windows.net/vehiclephotos/" + widget.item.stockNum.toString() + "_FOTO1.jpg"),
                  Image.network("https://junkerbernird.blob.core.windows.net/vehiclephotos/" + widget.item.stockNum.toString() + "_FOTO2.jpg"),
                  Image.network("https://junkerbernird.blob.core.windows.net/vehiclephotos/" + widget.item.stockNum.toString() + "_FOTO3.jpg"),
                  Image.network("https://junkerbernird.blob.core.windows.net/vehiclephotos/" + widget.item.stockNum.toString() + "_FOTO4.jpg"),
                  Image.network("https://junkerbernird.blob.core.windows.net/vehiclephotos/" + widget.item.stockNum.toString() + "_FOTO5.jpg"),
                  Image.network("https://junkerbernird.blob.core.windows.net/vehiclephotos/" + widget.item.stockNum.toString() + "_FOTO6.jpg"),
                  
                ]
              ),
            ),
            Divider(),
            FutureBuilder<CarPayload>(
              future: Networking().getDetails(
                widget.item.stockNum),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  details = snapshot.data;

                  return ListView.separated(
                    itemBuilder: (context, position) {
                      final item = details.carDetails[position];
                      return ListTile(
                        title: Text(item.parts[position].toString()),
                        trailing: RaisedButton(
                          onPressed: () {

                          },
                        ),
                        
                      );
                    },
                    separatorBuilder: (context, position) => Divider(),
                    itemCount: snapshot.data.carDetails.length);
                } else if(snapshot.hasError){
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
              }

            )
            

          ],
        ),
      ),
      // body: Column(
      //   children: <Widget>[
      //     ListTile(
      //       title: Text(widget.item.stockNum.toString()),
      //     )
      //   ],
      // ),

    );
  }
}