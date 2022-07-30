import 'Batidas.dart';

class Registroponto {
  late String id;
  late String guid;
  late bool podeBater;
  late List<Batidas> batidas;

  Registroponto(
      {required this.id,
      required this.guid,
      required this.podeBater,
      required this.batidas});

  Registroponto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    podeBater = json['podeBater'];
    if (json['batidas'] != null) {
      batidas = <Batidas>[];
      json['batidas'].forEach((v) {
        batidas.add(new Batidas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guid'] = this.guid;
    data['podeBater'] = this.podeBater;
    if (this.batidas != null) {
      data['batidas'] = this.batidas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
