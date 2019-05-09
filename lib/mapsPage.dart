import 'package:flutter/material.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Como llegar"),
        backgroundColor: Color.fromRGBO(172, 44, 58, 1),
      ),
      body:Container(
         decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end:Alignment.bottomCenter,
                colors: [
                  Colors.grey[800],
                  Colors.grey[700],
                  Colors.grey[600],
                  Colors.grey[500],
                ]
              )
            ),
      )
    );
  }
}
