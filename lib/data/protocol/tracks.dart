class Tracks {
  String name;
  int id;
  List<Ar> ar;
  Al al;
  int mv;

  Tracks({
    this.name,
    this.id,
    this.ar,
    this.al,
    this.mv,
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

    al = json['al'] != null ? Al.fromJson(json['al']) : null;

    mv = json['mv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.ar != null) {
      data['ar'] = this.ar.map((v) => v.toJson()).toList();
    }

    if (this.al != null) {
      data['al'] = this.al.toJson();
    }

    data['mv'] = this.mv;
    return data;
  }
}

class Ar {
  int id;
  String name;

  Ar({
    this.id,
    this.name,
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
  int id;
  String name;
  String picUrl;

  Al({
    this.id,
    this.name,
    this.picUrl,
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
