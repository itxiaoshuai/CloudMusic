class SearchUser {
  int userId;
  bool followed;
  String nickname;
  String avatarUrl;
  String signature;
  static SearchUser fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    SearchUser follow = SearchUser();
    follow.userId = map['userId'];
    follow.followed = map['followed'];
    follow.nickname = map['nickname'];
    follow.avatarUrl = map['avatarUrl'];
    follow.signature = map['signature'];
    return follow;
  }
}