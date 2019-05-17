import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Junker Bernird"),
          backgroundColor: new Color.fromRGBO(172, 44, 58, 1)),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            //   child: Image.asset("images/bernirdlogo.png"),
            // ),
            Container(
              child: CarouselSlider(
                height: 193.0,
                enableInfiniteScroll: true,
                autoPlay: true,
                items: <Widget>[
                  Image.asset(
                      "images/about_header1.png"),
                  Image.asset(
                      "images/about_header2.png"),
                  Image.asset(
                      "images/about_header3.png")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "¿Quiénes Somos?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '''El super Junker bernird se origino en el Barrio Corillo, carretera 149 km 60.4 Villalba PR, en el año 1991, operado por su dueño (Angel B. Torres) y un empleado. Super Junker Bernird comenzo con aproximadamente cincuenta (50) vehiculos en los 2.5 acres de terreno y para el año 1995 mediante aprobacion de la Adminitracion de Reglamentos y Permisos de Puerto Rico se obtuvo el permiso para la venta de vehiculos de motor, dando nacimiento a Bernird Auto Sales. Actualmente el Super Junker Bernird y Bernird Auto Sales cuentan con mas de 130 acres de terreno, completamente llenos de unidades y mas de treinta (30) empleados para atender las necesidaeds de todos nuestros clientes. Hoy en dia Super Junker Bernird y Bernird Auto Sales continuan creciendo, brindando un mejor servicio cada dia''',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
