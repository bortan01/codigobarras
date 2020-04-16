import 'package:codigobarras/src/block/scan_block.dart';
import 'package:codigobarras/src/model/ScanModeel.dart';
import 'package:codigobarras/src/utils/utils.dart' as utils;

import 'package:flutter/material.dart';

class MapaPage extends StatelessWidget {
  final scanBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scanBloc.obtenerScans();
    return StreamBuilder(
        stream: scanBloc.ScanStream,

        builder:(BuildContext context, AsyncSnapshot<List<ScanModel>>  snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data != null) {
          if(snapshot.data.length>0){
            final scans = snapshot.data;
            return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (context, i ){
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direccion){
                    scanBloc.borrarScan(scans[i].id);
                  },
                  background: new Container(color: Colors.redAccent,),
                  child: new ListTile(
                    onTap: ()=> utils.abrirScan(scans[i] , context),
                    leading: new Icon(Icons.map, color:  Theme.of(context).primaryColor,),
                    title: new Text(scans[i].valor),
                    subtitle: new Text('ID: ${scans[i].id}'),
                    trailing: new Icon(Icons.keyboard_arrow_right, color:  Colors.grey,),
                  ),
                );
              },

            );
          }else{
            return new Center(child: new Text("hay cero elementos"));
          }

        } else {
          return Center(child: new Text("snapshot es null"));
        }
      } else {
        return new  Center(child: new CircularProgressIndicator());
      }
    });



  }
}
