class Artist {
  late int id;
  late String name;
  late String picUrl;
  late int accountId;
  static Artist fromJson(Map<String, dynamic> map) {
    Artist follow = Artist();
    follow.name = map['name'];
    follow.picUrl = map['picUrl'];
    follow.accountId = map['accountId'];
    return follow;
  }
}