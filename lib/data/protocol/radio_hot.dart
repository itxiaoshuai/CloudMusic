class HotRadio {
  late int code;

  late List<DjRadios> djRadios;

  static HotRadio fromJson(Map<String, dynamic> map) {
    HotRadio hotRadio = HotRadio();
    hotRadio.code = map['code'];
    hotRadio.djRadios = []..addAll(
        (map['djRadios'] as List).map((o) => DjRadios.fromJson(o)));
    return hotRadio;
  }
}

class DjRadios {
  late int id;
  late String name;
  late String picUrl;
  late int subCount;

  static DjRadios fromJson(Map<String, dynamic> map) {
    DjRadios data = DjRadios();
    data.name = map['name'];
    data.picUrl = map['picUrl'];
    data.id = map['id'];
    data.subCount = map['subCount'];
    return data;
  }
}
