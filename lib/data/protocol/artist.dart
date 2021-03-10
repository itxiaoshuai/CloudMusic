class Artist {
  int id;
  String name;
  String picUrl;
  int accountId;
  static Artist fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Artist follow = Artist();
    follow.name = map['name'];
    follow.picUrl = map['picUrl'];
    follow.accountId = map['accountId'];
    return follow;
  }
}