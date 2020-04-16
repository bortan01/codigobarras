import 'package:latlong/latlong.dart';
class ScanModel {

  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
    id: json["id"],
    tipo: json["tipo"],
    valor: json["valor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipo": tipo,
    "valor": valor,
  };

  LatLng getLatLong(){
  final lalo = valor.substring(4).split(',');
  final lat = double.parse(lalo[0]);
  final lon = double.parse(lalo[1]);
  return new LatLng(lat, lon);

}

}