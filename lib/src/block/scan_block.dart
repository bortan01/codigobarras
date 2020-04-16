import 'dart:async';

import 'package:codigobarras/src/block/validator.dart';
import 'package:codigobarras/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();
  //static final ScansBloc _singletonHttp = new ScansBloc._internal();


  factory ScansBloc() {
    return _singleton;
  }
  ScansBloc._internal() {
    // obtener scans de la base de datos
    obtenerScans();
  }

  final _scanController = new StreamController<List<ScanModel>>.broadcast();
  

  // inicializacion
  Stream<List<ScanModel>> get ScanStream => _scanController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get ScanStreamHttp => _scanController.stream.transform(validarHttp);
  dispose(){
    _scanController?.close();
  }

  obtenerScans() async{
    _scanController.sink.add(await DBProvider.db.getTodosScans());

  }

  borrarScan(int id ) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScansTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

  agregarScan(ScanModel model) async {
   await DBProvider.db.nuevoScan(model);
    obtenerScans();
  }



}
