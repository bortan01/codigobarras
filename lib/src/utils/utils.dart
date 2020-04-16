import 'package:flutter/material.dart';
import 'package:codigobarras/src/model/ScanModeel.dart';
import 'package:url_launcher/url_launcher.dart';
abrirScan(ScanModel scanModel, BuildContext context) async {
if (scanModel.tipo == 'http') {
  if (await canLaunch(scanModel.valor)) {
    await launch(scanModel.valor);
  } else {
    throw 'Could not launch ${scanModel.valor}';
  }
}else{
  Navigator.pushNamed(context, 'mapa', arguments: scanModel);
 // print("geo");
}
  
  

}