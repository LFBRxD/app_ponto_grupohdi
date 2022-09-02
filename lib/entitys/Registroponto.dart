import 'Batidas.dart';

class Registroponto {
  late String id;
  late String guid;
  late bool canHit;
  late List<Batidas> hits;

  Registroponto(
      {required this.id,
      required this.guid,
      required this.canHit,
      required this.hits});

  Registroponto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    canHit = json['can_hit'];
    if (json['hits'] != null) {
      hits = <Batidas>[];
      json['hits'].forEach((v) {
        hits.add(Batidas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guid'] = this.guid;
    data['can_hit'] = this.canHit;
    if (this.hits != null) {
      data['hits'] = this.hits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
