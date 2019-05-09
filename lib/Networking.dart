import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:material_drawer/Results.dart';
import 'package:material_drawer/buypage.dart';


class Networking {

  final String listUrl = "https://admin.junkerbernird.com/api/vehicles/list/";
  final String buyUrl  = "https://admin.junkerbernird.com/api/vehicles/vehicleprofile?stocknum=";

  Future<CarPayload> getDetails(String stockNum) async {
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());
    var detailsRes = await http.get(Uri.encodeFull(buyUrl + stockNum), headers: {
      "content-type": "application/json",
      "token": base64.encode(
          utf8.encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))
    });
   
    if (detailsRes.statusCode == 200) {
      var data = jsonDecode(detailsRes.body);
   //   print(data);
      return CarPayload.fromJson(data);
    } else {
      throw Exception('Failed to load details');
    }

  }


  Future<Results> getPartsResult(String _makesSelection, String _modelSelection, 
    int _fromYear, int _toYear, String _partsSelection) async {
   // print("get Part List----------------------------------------------");
    var date = new DateFormat.yMMMMd().format(new DateTime.now().toUtc());
    var time = new DateFormat.jm().format(new DateTime.now().toUtc());
    //  var makeId = "1";
    Map jsonData = {
      "makeId": _makesSelection,
      "modelId": _modelSelection,
      "yearFrom": _fromYear.toString(),
      "yearTo": _toYear.toString(),
      "partId": _partsSelection
    };

    var partListRes = await http.post(
        Uri.encodeFull(listUrl),
        headers: {
          "token": base64.encode(utf8
              .encode("9cec20bea9c34668bc443b67a3e99e23|" + date + " " + time))
        },
        body: jsonData);

    if (partListRes.statusCode == 200) {
      var data = json.decode(partListRes.body);
      return Results.fromJson(data);
    } else {
      throw Exception('Failed to load parts');
    }
  }

}