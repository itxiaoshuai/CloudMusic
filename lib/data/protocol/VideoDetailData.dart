class VideoDetailData {
  late  int code;
  late Data data;

  static VideoDetailData fromJson(Map<String, dynamic> map) {
    VideoDetailData videoDetailData = VideoDetailData();
    videoDetailData.code = map['code'];
    videoDetailData.data = Data.fromJson(map['data']);
    return videoDetailData;
  }
}

class Data {
late String vid;
late String coverUrl;
late String title;
late String description;
late int praisedCount;
late int commentCount;
late int shareCount;
late int subscribeCount;
late int publishTime;
late String avatarUrl;
late int width;
late int height;
late Creator creator;

  static Data fromJson(Map<String, dynamic> map) {
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
late bool followed;
late int userType;
late int accountStatus;
late int userId;
late String nickname;
late String avatarUrl;

  static Creator fromJson(Map<String, dynamic> map) {
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
