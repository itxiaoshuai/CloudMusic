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

class Follow {
  int userId;
  bool followed;
  String nickname;
  String avatarUrl;

  static Follow fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Follow follow = Follow();
    follow.userId = map['userId'];
    follow.followed = map['followed'];
    follow.nickname = map['nickname'];
    follow.avatarUrl = map['avatarUrl'];
    return follow;
  }
}
