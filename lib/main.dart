
import 'package:codigobarras/src/pages/HomePagee.dart';
import 'package:codigobarras/src/pages/MagePage.dart';
import 'package:codigobarras/src/pages/mapa_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRRreader',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'mapa' : (BuildContext context) => MapaPageX(),
   //     'prueba' : (BuildContext context) => LandingScreen()
      },
      theme: new ThemeData(
          primaryColor: Colors.redAccent
      ),

    );
  }
}