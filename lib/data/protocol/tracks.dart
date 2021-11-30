class Tracks {
  late String name;
  late int id;
  late List<Ar> ar;
  late Al al;
  late int mv;

  Tracks({
    required this.name,
    required this.id,
    required this.ar,
    required this.al,
    required this.mv,
  });

  Tracks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['ar'] != null) {
      ar = <Ar>[];
      json['ar'].forEach((v) {
        ar.add(Ar.fromJson(v));
      });
    }
    al = (json['al'] != null ? Al.fromJson(json['al']) : null)!;

    mv = json['mv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['ar'] = this.ar.map((v) => v.toJson()).toList();

    data['al'] = this.al.toJson();

    data['mv'] = this.mv;
    return data;
  }
}

class Ar {
 late int id;
 late String name;

  Ar({
    required this.id,
    required this.name,
  });

  Ar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Al {
  late int id;
  late String name;
  late String picUrl;

  Al({
    required this.id,
    required this.name,
    required this.picUrl,
  });

  Al.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picUrl'] = this.picUrl;
    return data;
  }
}
