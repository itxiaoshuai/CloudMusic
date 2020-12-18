class VideoDetailData {
  int code;
  Data data;

  static VideoDetailData fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    VideoDetailData videoDetailData = VideoDetailData();
    videoDetailData.code = map['code'];
    videoDetailData.data = Data.fromJson(map['data']);
    return videoDetailData;
  }
}

class Data {
  String vid;
  String coverUrl;
  String title;
  String description;
  int praisedCount;
  int commentCount;
  int shareCount;
  int subscribeCount;
  int publishTime;
  String avatarUrl;
  int width;
  int height;
  Creator creator;

  static Data fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Data data = Data();
    data.vid = map['vid'];
    data.coverUrl = map['coverUrl'];
    data.title = map['title'];
    data.description = map['description'];
    data.praisedCount = map['praisedCount'];
    data.commentCount = map['commentCount'];
    data.shareCount = map['shareCount'];
    data.subscribeCount = map['subscribeCount'];
    data.publishTime = map['publishTime'];
    data.avatarUrl = map['avatarUrl'];
    data.width = map['width'];
    data.height = map['height'];
    data.creator = Creator.fromJson(map['creator']);
    return data;
  }
}

class Creator {
  bool followed;
  int userType;
  int accountStatus;
  int userId;
  String nickname;
  String avatarUrl;

  static Creator fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Creator creator = Creator();
    creator.followed = map['followed'];
    creator.userType = map['userType'];
    creator.accountStatus = map['accountStatus'];
    creator.userId = map['userId'];
    creator.nickname = map['nickname'];
    creator.avatarUrl = map['avatarUrl'];

    return creator;
  }
}
