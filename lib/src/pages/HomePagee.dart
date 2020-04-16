import 'dart:io';

import 'package:codigobarras/src/block/scan_block.dart';
import 'package:codigobarras/src/model/ScanModeel.dart';
import 'package:codigobarras/src/pages/DireccionPage.dart';
import 'package:codigobarras/src/pages/MagePage.dart';
import 'package:codigobarras/src/utils/utils.dart' as utils;
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
//import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:barcode_scan/barcode_scan.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc= new ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("QR Scanner"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.delete_forever), onPressed: (){
            scansBloc.borrarScansTodos();
          }
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        onPressed:()=> scanner(context), child: new Icon(Icons.filter_center_focus,),
        backgroundColor: Theme.of(context).primaryColor,
      ),

    );
  }

  _crearBottonNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Mapas')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5),
            title: Text('Direcciones')
        ),
      ],
    );
  }

  scanner(BuildContext context) async {

    ///https://www.marca.com/
    ///geo:40.689879098597345,-73.89745130976566
//    String futureString = "";
    String futureString = "https://www.marca.com/";

//    try{
//      futureString = await BarcodeScanner.scan();
//    }catch(e){
//      futureString = e.toString();
//      print(futureString);
//    }
//    print("el future String"+ futureString);
//
    print("sss");
    if (futureString != null) {
      final scan = ScanModel(valor: "https://www.marca.com/", tipo: 'http');
      scansBloc.agregarScan(scan);

//      final scan2 = ScanModel(valor: "geo:40.689879098597345,-73.89745130976566");
//      scansBloc.agregarScan(scan2);

      if (Platform.isIOS) {
          Future.delayed(new Duration(milliseconds: 750),() {
            utils.abrirScan(scan, context);
          });
      }else{
        utils.abrirScan(scan, context);
      }
      


    }

  }

  _callPage(int PaginaActual) {
    switch(PaginaActual) {
      case 0: return MapaPage();
      case 1: return DireccionPage();
        break;
      default: return MapaPage();
    }
  }
}