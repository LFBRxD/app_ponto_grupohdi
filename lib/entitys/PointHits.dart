class PointHits {
  bool? canHit;
  List<Hit>? hit;

  PointHits({this.canHit, this.hit});

  PointHits.fromJson(Map<String, dynamic> json) {
    canHit = json['can_hit'];
    if (json['hit'] != null) {
      hit = <Hit>[];
      json['hit'].forEach((v) {
        hit!.add(Hit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['can_hit'] = canHit;
    if (hit != null) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    return data;
  }
}
