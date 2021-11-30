import 'package:cloud_music/data/protocol/Follow.dart';

class Fans {
  late int code;
  late bool more;
  late List<Follow> followeds;

  static Fans fromJson(Map<String, dynamic> map) {
    Fans fans = Fans();
    fans.code = map['code'];
    fans.followeds = []
      ..addAll((map['followeds'] as List).map((o) => Follow.fromJson(o)));
    return fans;
  }
}
