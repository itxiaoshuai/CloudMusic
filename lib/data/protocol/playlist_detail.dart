//class PlaylistDetail {
//  Playlist playlist;
//
//  PlaylistDetail({
//    this.playlist,
//  });
//
//  PlaylistDetail.fromJson(Map<String, dynamic> json) {
//    playlist = json['playlist'] != null
//        ? new Playlist.fromJson(json['playlist'])
//        : null;
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.playlist != null) {
//      data['playlist'] = this.playlist.toJson();
//    }
//    return data;
//  }
//}

class PlaylistDetail {
  Creator creator;
  List<Tracks> tracks;
  List<TrackIds> trackIds;
  int createTime;
  bool highQuality;
  int userId;
  int cloudTrackCount; //云端歌曲数
  int subscribedCount; //订阅数
  String coverImgUrl;
  int trackCount; //歌曲数
  int playCount; //播放量
  String description; //描述
  List<String> tags; //标签[华语,流行,欧美]
  String name; //标题
  int id;
  int shareCount; //分享次数
  int commentCount; //评论数
  bool subscribed; //是否收藏
  PlaylistDetail(
      {this.subscribed,
      this.creator,
      this.tracks,
      this.trackIds,
      this.createTime,
      this.highQuality,
      this.userId,
      this.cloudTrackCount,
      this.subscribedCount,
      this.coverImgUrl,
      this.trackCount,
      this.playCount,
      this.description,
      this.tags,
      this.name,
      this.id,
      this.shareCount,
      this.commentCount});

  PlaylistDetail.fromJson(Map<String, dynamic> json) {
    subscribed = json['subscribed'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    if (json['tracks'] != null) {
      tracks = new List<Tracks>();
      json['tracks'].forEach((v) {
        tracks.add(new Tracks.fromJson(v));
      });
    }
    if (json['trackIds'] != null) {
      trackIds = new List<TrackIds>();
      json['trackIds'].forEach((v) {
        trackIds.add(new TrackIds.fromJson(v));
      });
    }

    createTime = json['createTime'];
    highQuality = json['highQuality'];
    userId = json['userId'];
    cloudTrackCount = json['cloudTrackCount'];
    subscribedCount = json['subscribedCount'];
    coverImgUrl = json['coverImgUrl'];

    trackCount = json['trackCount'];

    playCount = json['playCount'];

    description = json['description'];
    tags = json['tags'].cast<String>();

    name = json['name'];
    id = json['id'];
    shareCount = json['shareCount'];

    commentCount = json['commentCount'];
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
  int province; //省(110000)
  String avatarUrl; //头像
  int gender; //性别
  int city; //市
  int birthday; //生日(时间戳装换毫秒值)
  int userId; //用户id
  String nickname; //鹿白川
  String signature; //话少慢热不喜交际 / 不推广 勿扰
  String backgroundUrl;
  List<String> expertTags; //标签[华语,流行,欧美]

  Creator({
    this.province,
    this.avatarUrl,
    this.gender,
    this.city,
    this.birthday,
    this.userId,
    this.nickname,
    this.signature,
    this.backgroundUrl,
    this.expertTags,
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
    expertTags = json['expertTags'].cast<String>();
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
    data['expertTags'] = this.expertTags;
    return data;
  }
}

class Experts {
  String s2;

  Experts({this.s2});

  Experts.fromJson(Map<String, dynamic> json) {
    s2 = json['2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['2'] = this.s2;
    return data;
  }
}

class Tracks {
  String name;
  int id;
  List<Ar> ar;
  Al al;
  int mv;

  Tracks({
    this.name,
    this.id,
    this.ar,
    this.al,
    this.mv,
  });

  Tracks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['ar'] != null) {
      ar = new List<Ar>();
      json['ar'].forEach((v) {
        ar.add(new Ar.fromJson(v));
      });
    }

    al = json['al'] != null ? new Al.fromJson(json['al']) : null;

    mv = json['mv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.ar != null) {
      data['ar'] = this.ar.map((v) => v.toJson()).toList();
    }

    if (this.al != null) {
      data['al'] = this.al.toJson();
    }

    data['mv'] = this.mv;
    return data;
  }
}

class Ar {
  int id;
  String name;

  Ar({
    this.id,
    this.name,
  });

  Ar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Al {
  int id;
  String name;
  String picUrl;

  Al({
    this.id,
    this.name,
    this.picUrl,
  });

  Al.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picUrl'] = this.picUrl;
    return data;
  }
}

class TrackIds {
  int id;
  int v;
  Null alg;

  TrackIds({this.id, this.v, this.alg});

  TrackIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    v = json['v'];
    alg = json['alg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['v'] = this.v;
    data['alg'] = this.alg;
    return data;
  }
}
