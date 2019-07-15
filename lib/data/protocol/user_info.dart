





class UserInfo {
  String backgroundUrl;

  @override
  String toString() {
    return 'UserInfo{backgroundUrl: $backgroundUrl, nickname: $nickname, avatarUrl: $avatarUrl, uid: $uid, vipType: $vipType, gender: $gender}';
  }

  String nickname;
  String avatarUrl;
  int uid;
  int vipType;
  int gender;
  UserInfo(
      {this.backgroundUrl,
        this.nickname,
        this.avatarUrl,
        this.uid,
        this.vipType,
   });

  UserInfo.fromJson(Map<String, dynamic> json) {
    backgroundUrl = json['backgroundUrl'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    uid = json['uid'];
    vipType = json['vipType'];
    gender = json['gender'];
  }


}
  
