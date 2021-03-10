
import 'package:cloud_music/data/protocol/Follow.dart';
class Follows {
  int code;
  int touchCount;
  bool more;
  List<Follow> follow;

  static Follows fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Follows follows = Follows();
    follows.code = map['code'];
    follows.follow = []
      ..addAll((map['follow'] as List ?? []).map((o) => Follow.fromJson(o)));
    return follows;
  }
}


