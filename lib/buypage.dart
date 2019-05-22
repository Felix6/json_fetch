import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_drawer/Networking.dart';
import 'package:material_drawer/Results.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:material_drawer/payPalWebView.dart';

class CarPayload {
  bool success = true;
  String errorMessage = "";
  PayloadBuyPage carDetails;
//  List<Parts> carParsts = List();

  CarPayload({this.success, this.errorMessage, this.carDetails});

  factory CarPayload.fromJson(Map<String, dynamic> json) {
    return new CarPayload(
        success: json["success"],
        errorMessage: json["errorMessage"].toString(),
        carDetails: PayloadBuyPage.fromJson(json["payload"]));
  }
}

class PayloadBuyPage {
  String year;
  String stockNum;
  String vin;
  String make;
  String model;
  String trim;
  String engine;
  String transmission;
  String color;
  List<Parts> parts;

  PayloadBuyPage(
      {this.year,
      this.stockNum,
      this.vin,
      this.make,
      this.model,
      this.trim,
      this.engine,
      this.transmission,
      this.color,
      this.parts});

  factory PayloadBuyPage.fromJson(Map<String, dynamic> json) {
//    var list = json['mid'] as List;
//    List<ExamsItems> midExam = list.map((i) => ExamsItems.fromJson(i)).toList();
    var partsFromJson = json["parts"] as List;
    List<Parts> parts = partsFromJson.map((i) => Parts.fromJson(i)).toList();
    return PayloadBuyPage(
        year: json["year"].toString(),
        stockNum: json["stockNum"].toString(),
        vin: json["vin"].toString(),
        make: json["make"].toString(),
        model: json["model"].toString(),
        trim: json["trim"].toString(),
        engine: json["engine"].toString(),
        transmission: json["transmission"].toString(),
        color: json["color"].toString(),
        parts: parts);
  }
}

class Parts {
  String partNum;
  String name;
  String price;
  String payPalUrl;

  Parts({this.partNum, this.name, this.price, this.payPalUrl});

  factory Parts.fromJson(Map<String, dynamic> json) {
    return new Parts(
        partNum: json["partNum"],
        name: json["name"],
        price: json["price"].toString(),
        payPalUrl: json["payPalUrl"]);
  }

  @override
  String toString() {
    return "partNum: $partNum, name: $name, price: $price, payPalUrl: $payPalUrl";
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
        title: Text("Super Junker Bernird"),
        backgroundColor: Color.fromRGBO(172, 44, 58, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: CarouselSlider(
                  height: 200.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  items: <Widget>[
                    Image.network(
                        "https://junkerbernird.blob.core.windows.net/vehiclephotos/" +
                            widget.item.stockNum.toString() +
                            "_FOTO1.jpg"),
                    Image.network(
                        "https://junkerbernird.blob.core.windows.net/vehiclephotos/" +
                            widget.item.stockNum.toString() +
                            "_FOTO2.jpg"),
                    Image.network(
                        "https://junkerbernird.blob.core.windows.net/vehiclephotos/" +
                            widget.item.stockNum.toString() +
                            "_FOTO3.jpg"),
                    Image.network(
                        "https://junkerbernird.blob.core.windows.net/vehiclephotos/" +
                            widget.item.stockNum.toString() +
                            "_FOTO4.jpg"),
                    Image.network(
                        "https://junkerbernird.blob.core.windows.net/vehiclephotos/" +
                            widget.item.stockNum.toString() +
                            "_FOTO5.jpg"),
                    Image.network(
                        "https://junkerbernird.blob.core.windows.net/vehiclephotos/" +
                            widget.item.stockNum.toString() +
                            "_FOTO6.jpg"),
                  ]),
            ),

            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FutureBuilder<CarPayload>(
                      future: Networking().getDetails(widget.item.stockNum),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          details = snapshot.data;
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, position) {
                                final item = details.carDetails.parts[position];
                                return ListTile(
                                  title: Text(item.name.toString(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  subtitle: Text("\$" + item.price.toString(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.green
                                    ),
                                  ),
                                  trailing: RaisedButton(
                                    child: Text(
                                      "Comprar",
                                      style: TextStyle(
                                        color: Colors.white

                                        ),
                                    ),
                                    color: Color.fromRGBO(172, 44, 58, 1),
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) => PayPalWebView(
                                         item.payPalUrl
                                        )
                                      ));
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, position) =>
                                  Divider(),
                              itemCount: snapshot.data.carDetails.parts.length);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        // TODO: check if list is empty to the show different UI


                        // While the Future is busy loading data, this is rendered
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
                      }),
                ],
              ),
            ),
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
