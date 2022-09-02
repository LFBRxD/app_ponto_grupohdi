class Batidas {
  bool? canHit;
  List<Hit>? hit;

  Batidas({this.canHit, this.hit});

  Batidas.fromJson(Map<String, dynamic> json) {
    canHit = json['can_hit'];
    if (json['hit'] != null) {
      hit = <Hit>[];
      json['hit'].forEach((v) {
        hit!.add(new Hit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['can_hit'] = this.canHit;
    if (this.hit != null) {
      data['hit'] = this.hit!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hit {
  int? id;
  String? createdAt;

  Hit({this.id, this.createdAt});

  Hit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    return data;
  }
}