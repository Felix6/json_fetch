import 'package:flutter/material.dart';
import 'carSalepage.dart';
class CarSaleSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendenos tu auto"),
        backgroundColor:  Color.fromRGBO(172, 44, 58, 1),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Image.asset("images/handmoneykey.png"),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(0,40,0,20),
            child: Text("¿Cómo funciona?",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(172, 44, 58, 1)
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.directions_car, size: 50.0, color: Colors.black,),
            title: Text("Envianos fotos e informacion basica de tu vehiculo.",
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          ListTile(
            leading: Icon(Icons.insert_drive_file, size: 50.0, color: Colors.black,),
            title: Text("Evaluamos tu solicitud en menos de 24 horas.",
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.attach_money, size: 50.0, color: Colors.black,),
            title: Text("Realizamos el pago inmediatamente tu solicitud haya sido aprobada.",
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
    
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Align(  
      child: RawMaterialButton(
          fillColor: Color.fromRGBO(172, 44, 58, 1),
          child:Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 20.0
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(width: 8.0,),
                Text("Comenzar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0
                  ),
                ),
              ],
            ), 
           ),
          shape: const StadiumBorder(),
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CarSalePage()));
          },
        ),
      ),
    ),
        ]
    
      ),
      )
    );
  }
}