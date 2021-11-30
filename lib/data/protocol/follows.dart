
import 'package:cloud_music/data/protocol/Follow.dart';
class Follows {
 late int code;
 late int touchCount;
 late bool more;
 late List<Follow> follow;

  static Follows fromJson(Map<String, dynamic> map) {
    Follows follows = Follows();
    follows.code = map['code'];
    follows.follow = []
      ..addAll((map['follow'] as List).map((o) => Follow.fromJson(o)));
    return follows;
  }
}


