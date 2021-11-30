class SearchUser {
  late int userId;
  late bool followed;
  late String nickname;
  late String avatarUrl;
  late String signature;

  static SearchUser fromJson(Map<String, dynamic> map) {
    SearchUser follow = SearchUser();
    follow.userId = map['userId'];
    follow.followed = map['followed'];
    follow.nickname = map['nickname'];
    follow.avatarUrl = map['avatarUrl'];
    follow.signature = map['signature'];
    return follow;
  }
}
