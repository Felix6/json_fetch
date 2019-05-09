import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ContactWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Junker Bernird"),
        backgroundColor: Color.fromRGBO(172, 44, 58, 1),
      ),
      body: SafeArea(
        child: WebviewScaffold(
          //
          url: "https://www.bmstudiopr.com/junker_bernird/feeds.php",
          initialChild: Center(
            child: CircularProgressIndicator(backgroundColor: Colors.blue,),
          ),
        ),
      ),
    );
  }
}