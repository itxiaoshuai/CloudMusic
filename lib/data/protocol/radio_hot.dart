class HotRadio {
  int code;

  List<DjRadios> djRadios;

  static HotRadio fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    HotRadio hotRadio = HotRadio();
    hotRadio.code = map['code'];
    hotRadio.djRadios = []
      ..addAll((map['djRadios'] as List ?? []).map((o) => DjRadios.fromJson(o)));
    return hotRadio;
  }
}

class DjRadios {
  int id;
  String name;
  String picUrl;
  int subCount;
  static DjRadios fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    DjRadios data = DjRadios();
    data.name = map['name'];
    data.picUrl = map['picUrl'];
    data.id = map['id'];
    data.subCount = map['subCount'];
    return data;
  }
}
