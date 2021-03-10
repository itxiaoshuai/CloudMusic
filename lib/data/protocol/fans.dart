import 'package:cloud_music/data/protocol/Follow.dart';
class Fans {
  int code;
  bool more;
  List<Follow> followeds;

  static Fans fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Fans fans = Fans();
    fans.code = map['code'];
    fans.followeds = []
      ..addAll((map['followeds'] as List ?? []).map((o) => Follow.fromJson(o)));
    return fans;
  }
}


