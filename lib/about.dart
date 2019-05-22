import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Super Junker Bernird"),
          backgroundColor: new Color.fromRGBO(172, 44, 58, 1)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: CarouselSlider(
                  height: 193.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  items: <Widget>[
                    Image.asset("images/about_header1.png"),
                    Image.asset("images/empleados.jpeg"),
                    Image.asset("images/about_header3.png")
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  "¿Quiénes Somos?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '''El Super Junker Bernird se originó en el Barrio Corillo, carretera 149 km 60.4 Villalba PR, en el año 1991, operado por su dueño (Angel B. Torres) y un empleado. Super Junker Bernird comenzó con aproximadamente cincuenta (50) vehículos en los 2.5 acres de terreno y para el año 1995 mediante aprobación de la Administración de Reglamentos y Permisos de Puerto Rico se obtuvo el permiso para la venta de vehículos de motor, dando nacimiento a Bernird Auto Sales. Actualmente el Super Junker Bernird y Bernird Auto Sales cuentan con más de 130 acres de terreno, completamente llenos de unidades y más de treinta (30) empleados para atender las necesidades de todos nuestros clientes. Hoy en día Super Junker Bernird y Bernird Auto Sales continúan creciendo, brindando un mejor servicio cada día.''',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Image.asset("images/equipotrabajo.png"),
            ],
          ),
        ),
      ),
    );
  }
}
