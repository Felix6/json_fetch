import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:material_drawer/buypage.dart';

class PayPalWebView extends StatefulWidget {
final String paypalurl;

  PayPalWebView(this.paypalurl);

  @override
  _PayPalWebViewState createState() => _PayPalWebViewState();
}

class _PayPalWebViewState extends State<PayPalWebView> {
  PayPalWebView paypalUrl;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Junker Bernird"),
        backgroundColor: Color.fromRGBO(172, 44, 58, 1),
      ),
      body: SafeArea(
        child: WebviewScaffold(
          url: widget.paypalurl.toString(),
          initialChild: Center(
            child: CircularProgressIndicator(backgroundColor: Colors.blue,),
          ),
        ),
      ),
    );
  }
}