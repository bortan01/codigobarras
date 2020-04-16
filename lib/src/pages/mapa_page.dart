import 'package:codigobarras/src/model/ScanModeel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
void main() => runApp(MapaPageX());

class MapaPageX extends StatefulWidget {
  @override
  _MapaPageXState createState() => _MapaPageXState();
}

class _MapaPageXState extends State<MapaPageX> {
MapController mapController = new MapController();

String tipoMapa = "streets";

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      theme: new ThemeData(
          primaryColor: Colors.deepPurple
      ),
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Coordenadas QR'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.my_location),
                onPressed: (){
                 // mapController.move(scan.getLatLong(), 15.0);
                  final latidud = (scan.getLatLong().latitude);
                 final longitud =  (scan.getLatLong().longitude);
                 print(latidud.toString());
                 print(longitud.toString());

                 mapController.move(LatLng(latidud, longitud), 15.0);
                })
          ],
        ),
       body: _crearFlutterMap(scan),
        floatingActionButton: _creaarBotonFlotante(context),
      ),
    );
  }

  _crearFlutterMap(ScanModel scan) {
  return new FlutterMap(
    mapController: mapController,
      options: new MapOptions(
        center: scan.getLatLong(),
        zoom: 5,
      ),
    layers: [
      _crearMapa(),
      _crearMarcadores(scan),
    ],
  );
  }

  _crearMapa() {
    //{z} es el zoom
    //{x}/{y} es latutud y longitud
    //@2x.png la resolucion y formato


    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken': 'pk.eyJ1IjoiZmVybmFuZG9tb3ZpZSIsImEiOiJjazkxaHdud24wMDk0M2ducTNhcXp6NG5hIn0.nIWAi1qRcNjeBhjjOC150g',
          'id': 'mapbox.$tipoMapa'
          //tipos de id streets, dark, light, outdoors, satellite
        }
    );

  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        new Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLong(),
          builder: (context){
            return Container(
              child: new Icon(
                Icons.location_on,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        )
      ]
    );
  }

  _creaarBotonFlotante(BuildContext context) {
    return new FloatingActionButton(
      onPressed: (){
        if (tipoMapa == "streets") {
          tipoMapa = 'dark';
        }else if(tipoMapa == 'dark'){
          tipoMapa = 'light';
        }else if(tipoMapa == 'light'){
          tipoMapa = 'outdoors';
        }else if(tipoMapa == 'outdoors'){
          tipoMapa = 'satellite';
        }else{
          tipoMapa = 'streets';
        }
        setState(() {

          print(tipoMapa);
         // mapController.move(, zoom)
        });

      },
      child: new Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
