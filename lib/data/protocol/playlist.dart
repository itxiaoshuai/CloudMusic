import 'tracks.dart';

class Playlist {
  late Creator creator;

  @override
  String toString() {
    return 'PlaylistDetail{creator: $creator, tracks: $tracks, trackIds: $trackIds, createTime: $createTime, highQuality: $highQuality, userId: $userId, cloudTrackCount: $cloudTrackCount, subscribedCount: $subscribedCount, coverImgUrl: $coverImgUrl, trackCount: $trackCount, playCount: $playCount, description: $description, tags: $tags, name: $name, id: $id, shareCount: $shareCount, commentCount: $commentCount, subscribed: $subscribed}';
  }

  late List<Tracks> tracks;
  late List<TrackIds> trackIds;
  late int createTime;
  late bool highQuality;
  late int userId;
  late int cloudTrackCount; //云端歌曲数
  late int subscribedCount; //订阅数
  late String coverImgUrl;
  late int trackCount; //歌曲数
  late int playCount; //播放量
  late String description; //描述
  late List<String> tags; //标签[华语,流行,欧美]
  late String name; //标题
  late int id;
  late int shareCount; //分享次数
  late int commentCount; //评论数
  late bool subscribed; //是否收藏
  Playlist(
      {required this.subscribed,
      required this.creator,
      required this.tracks,
      required this.trackIds,
      required this.createTime,
      required this.highQuality,
      required this.userId,
      required this.cloudTrackCount,
      required this.subscribedCount,
      required this.coverImgUrl,
      required this.trackCount,
      required this.playCount,
      required this.description,
      required this.tags,
      required this.name,
      required this.id,
      required this.shareCount,
      required this.commentCount});

  Playlist.fromJson(Map<dynamic, dynamic> json) {
    // subscribed = json['subscribed'];
    creator = (json['creator'] != null
        ? new Creator.fromJson(json['creator'])
        : null)!;
    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) {
        tracks.add(Tracks.fromJson(v));
      });
    }
    // if (json['trackIds'] != null) {
    //   trackIds = <TrackIds>[];
    //   json['trackIds'].forEach((v) {
    //     trackIds.add(TrackIds.fromJson(v));
    //   });
    // }
    //
    // createTime = json['createTime'];
    // highQuality = json['highQuality'];
    // userId = json['userId'];
    // cloudTrackCount = json['cloudTrackCount'];
    // subscribedCount = json['subscribedCount'];
    coverImgUrl = json['coverImgUrl'];
    //
    trackCount = json['trackCount'];
    //
    playCount = json['playCount'];
    //
    if (json['description'] != null) {
      description = json['description'];
    }

    // if (json['tags'] != null) {
    //   tags = json['tags'].cast<String>();
    // }
    //
    name = json['name'];
    id = json['id'];
    if (json['shareCount'] != null) {
      shareCount = json['shareCount'];
    }

    if (json['commentCount'] != null) {
      commentCount = json['commentCount'];
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscribed'] = this.subscribed;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    if (this.tracks != null) {
      data['tracks'] = this.tracks.map((v) => v.toJson()).toList();
    }
    if (this.trackIds != null) {
      data['trackIds'] = this.trackIds.map((v) => v.toJson()).toList();
    }
    data['userId'] = this.userId;
    data['cloudTrackCount'] = this.cloudTrackCount;
    data['subscribedCount'] = this.subscribedCount;
    data['coverImgUrl'] = this.coverImgUrl;
    data['trackCount'] = this.trackCount;
    data['playCount'] = this.playCount;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['name'] = this.name;
    data['id'] = this.id;
    data['shareCount'] = this.shareCount;
    data['commentCount'] = this.commentCount;
    return data;
  }
}

class Creator {
  late int province; //省(110000)
  late String avatarUrl; //头像
  late int gender; //性别
  late int city; //市
  late int birthday; //生日(时间戳装换毫秒值)
  late int userId; //用户id
  late String nickname; //鹿白川
  late String signature; //话少慢热不喜交际 / 不推广 勿扰
  late String backgroundUrl;

  Creator({
    required this.province,
    required this.avatarUrl,
    required this.gender,
    required this.city,
    required this.birthday,
    required this.userId,
    required this.nickname,
    required this.signature,
    required this.backgroundUrl,
  });

  Creator.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    avatarUrl = json['avatarUrl'];
    gender = json['gender'];
    city = json['city'];
    birthday = json['birthday'];
    userId = json['userId'];
    nickname = json['nickname'];
    signature = json['signature'];
    backgroundUrl = json['backgroundUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    data['avatarUrl'] = this.avatarUrl;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['birthday'] = this.birthday;
    data['userId'] = this.userId;
    data['nickname'] = this.nickname;
    data['signature'] = this.signature;
    data['backgroundUrl'] = this.backgroundUrl;
    return data;
  }
}

class Experts {
  late String s2;

  Experts({required this.s2});

  Experts.fromJson(Map<String, dynamic> json) {
    s2 = json['2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['2'] = this.s2;
    return data;
  }
}

class TrackIds {
  late int id;
  late int v;

  TrackIds({required this.id, required this.v});

  TrackIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['v'] = this.v;
    return data;
  }
}
