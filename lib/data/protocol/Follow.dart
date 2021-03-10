class Follow {
  int userId;
  bool followed;
  String nickname;
  String avatarUrl;
  String signature;
  static Follow fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Follow follow = Follow();
    follow.userId = map['userId'];
    follow.followed = map['followed'];
    follow.nickname = map['nickname'];
    follow.avatarUrl = map['avatarUrl'];
    follow.signature = map['signature'];
    return follow;
  }
}