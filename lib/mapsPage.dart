import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MapsWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Junker Bernird"),
        backgroundColor: Color.fromRGBO(172, 44, 58, 1),
      ),
      body: SafeArea(
        child: WebviewScaffold(
          url: "https://goo.gl/maps/obHa61Xim8KyjEU18",
          initialChild: Center(
            child: CircularProgressIndicator(backgroundColor: Colors.blue,),
          ),
        ),
      ),
    );
  }
}
