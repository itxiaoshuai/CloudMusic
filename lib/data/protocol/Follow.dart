class Follow {
 late int userId;
 late bool followed;
 late String nickname;
 late String avatarUrl;
 late String signature;
  static Follow fromJson(Map<String, dynamic> map) {
    Follow follow = Follow();
    follow.userId = map['userId'];
    follow.followed = map['followed'];
    follow.nickname = map['nickname'];
    follow.avatarUrl = map['avatarUrl'];
    follow.signature = map['signature'];
    return follow;
  }
}