class Batidas {
  late int id;
  late String dataRegistro;

  Batidas({required this.id, required this.dataRegistro});

  Batidas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataRegistro = json['dataRegistro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dataRegistro'] = this.dataRegistro;
    return data;
  }
}
