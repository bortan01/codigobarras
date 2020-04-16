import 'dart:async';

import 'package:codigobarras/src/model/ScanModeel.dart';

class Validators{
  final validarGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink){
      final geoScans = scans.where( (item) => item.tipo == 'geo').toList();
      sink.add(geoScans);
    }
  );

  final validarHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
      handleData: (scans, sink){
        final geoScans = scans.where( (item) => item.tipo == 'http').toList();
        sink.add(geoScans);
      }
  );

}