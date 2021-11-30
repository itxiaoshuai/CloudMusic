class LeaderBoardDetailModel {
  late Playlist playlist;
  late int code;

  LeaderBoardDetailModel({
    required this.playlist,
    required this.code,
  });

  LeaderBoardDetailModel.fromJson(Map<String, dynamic> json) {
    playlist = (json['playlist'] != null
        ? Playlist.fromJson(json['playlist'])
        : null)!;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['playlist'] = this.playlist.toJson();
    data['code'] = this.code;
    return data;
  }
}

class Playlist {
  late List<Subscribers> subscribers;
  late bool subscribed;
  late Creator creator;
  late List<Tracks> tracks;
  late int backgroundCoverId;
  late int trackUpdateTime;
  late int userId;
  late bool highQuality;
  late int specialType;
  late int updateTime;
  late int trackCount;
  late String commentThreadId;
  late int playCount;
  late int createTime;
  late int trackNumberUpdateTime;
  late int coverImgId;
  late String coverImgUrl;
  late int adType;
  late int privacy;
  late bool newImported;
  late int subscribedCount;
  late int cloudTrackCount;
  late String description;
  late bool ordered;
  late int status;
  late String name;
  late int id;
  late int shareCount;
  late String coverImgIdStr;
  late String toplistType;
  late int commentCount;

  Playlist(
      {required this.subscribers,
      required this.subscribed,
      required this.creator,
      required this.tracks,
      required this.backgroundCoverId,
      required this.trackUpdateTime,
      required this.userId,
      required this.highQuality,
      required this.specialType,
      required this.updateTime,
      required this.trackCount,
      required this.commentThreadId,
      required this.playCount,
      required this.createTime,
      required this.trackNumberUpdateTime,
      required this.coverImgId,
      required this.coverImgUrl,
      required this.adType,
      required this.privacy,
      required this.newImported,
      required this.subscribedCount,
      required this.cloudTrackCount,
      required this.description,
      required this.ordered,
      required this.status,
      required this.name,
      required this.id,
      required this.shareCount,
      required this.coverImgIdStr,
      required this.toplistType,
      required this.commentCount});

  Playlist.fromJson(Map<String, dynamic> json) {
    if (json['subscribers'] != null) {
      subscribers = <Subscribers>[];
      json['subscribers'].forEach((v) {
        subscribers.add(Subscribers.fromJson(v));
      });
    }
    subscribed = json['subscribed'];
    creator =
        (json['creator'] != null ? Creator.fromJson(json['creator']) : null)!;
    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) {
        tracks.add(Tracks.fromJson(v));
      });
    }

    backgroundCoverId = json['backgroundCoverId'];
    trackUpdateTime = json['trackUpdateTime'];
    userId = json['userId'];
    highQuality = json['highQuality'];
    specialType = json['specialType'];
    updateTime = json['updateTime'];
    trackCount = json['trackCount'];
    commentThreadId = json['commentThreadId'];
    playCount = json['playCount'];
    createTime = json['createTime'];
    trackNumberUpdateTime = json['trackNumberUpdateTime'];
    coverImgId = json['coverImgId'];
    coverImgUrl = json['coverImgUrl'];
    adType = json['adType'];
    privacy = json['privacy'];
    newImported = json['newImported'];
    subscribedCount = json['subscribedCount'];
    cloudTrackCount = json['cloudTrackCount'];
    description = json['description'];
    ordered = json['ordered'];
    status = json['status'];
    name = json['name'];
    id = json['id'];
    shareCount = json['shareCount'];
    coverImgIdStr = json['coverImgId_str'];
    toplistType = json['ToplistType'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subscribers'] = this.subscribers.map((v) => v.toJson()).toList();
    data['subscribed'] = this.subscribed;
    data['creator'] = this.creator.toJson();
    data['tracks'] = this.tracks.map((v) => v.toJson()).toList();

    data['backgroundCoverId'] = this.backgroundCoverId;
    data['trackUpdateTime'] = this.trackUpdateTime;
    data['userId'] = this.userId;
    data['highQuality'] = this.highQuality;
    data['specialType'] = this.specialType;
    data['updateTime'] = this.updateTime;
    data['trackCount'] = this.trackCount;
    data['commentThreadId'] = this.commentThreadId;
    data['playCount'] = this.playCount;
    data['createTime'] = this.createTime;
    data['trackNumberUpdateTime'] = this.trackNumberUpdateTime;
    data['coverImgId'] = this.coverImgId;
    data['coverImgUrl'] = this.coverImgUrl;
    data['adType'] = this.adType;
    data['privacy'] = this.privacy;
    data['newImported'] = this.newImported;
    data['subscribedCount'] = this.subscribedCount;
    data['cloudTrackCount'] = this.cloudTrackCount;
    data['description'] = this.description;
    data['ordered'] = this.ordered;
    data['status'] = this.status;
    data['name'] = this.name;
    data['id'] = this.id;
    data['shareCount'] = this.shareCount;
    data['coverImgId_str'] = this.coverImgIdStr;
    data['ToplistType'] = this.toplistType;
    data['commentCount'] = this.commentCount;
    return data;
  }
}

class Subscribers {
  late bool defaultAvatar;
  late int province;
  late int authStatus;
  late bool followed;
  late String avatarUrl;
  late int accountStatus;
  late int gender;
  late int city;
  late int birthday;
  late int userId;
  late int userType;
  late String nickname;
  late String signature;
  late String description;
  late String detailDescription;
  late int avatarImgId;
  late int backgroundImgId;
  late String backgroundUrl;
  late int authority;
  late bool mutual;
  late Null expertTags;
  late Null experts;
  late int djStatus;
  late int vipType;
  late Null remarkName;
  late String backgroundImgIdStr;
  late String avatarImgIdStr;

  Subscribers({
    required this.defaultAvatar,
    required this.province,
    required this.authStatus,
    required this.followed,
    required this.avatarUrl,
    required this.accountStatus,
    required this.gender,
    required this.city,
    required this.birthday,
    required this.userId,
    required this.userType,
    required this.nickname,
    required this.signature,
    required this.description,
    required this.detailDescription,
    required this.avatarImgId,
    required this.backgroundImgId,
    required this.backgroundUrl,
    required this.authority,
    required this.mutual,
    required this.expertTags,
    required this.experts,
    required this.djStatus,
    required this.vipType,
    required this.remarkName,
    required this.backgroundImgIdStr,
    required this.avatarImgIdStr,
  });

  Subscribers.fromJson(Map<String, dynamic> json) {
    defaultAvatar = json['defaultAvatar'];
    province = json['province'];
    authStatus = json['authStatus'];
    followed = json['followed'];
    avatarUrl = json['avatarUrl'];
    accountStatus = json['accountStatus'];
    gender = json['gender'];
    city = json['city'];
    birthday = json['birthday'];
    userId = json['userId'];
    userType = json['userType'];
    nickname = json['nickname'];
    signature = json['signature'];
    description = json['description'];
    detailDescription = json['detailDescription'];
    avatarImgId = json['avatarImgId'];
    backgroundImgId = json['backgroundImgId'];
    backgroundUrl = json['backgroundUrl'];
    authority = json['authority'];
    mutual = json['mutual'];
    expertTags = json['expertTags'];
    experts = json['experts'];
    djStatus = json['djStatus'];
    vipType = json['vipType'];
    remarkName = json['remarkName'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    avatarImgIdStr = json['avatarImgIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['defaultAvatar'] = this.defaultAvatar;
    data['province'] = this.province;
    data['authStatus'] = this.authStatus;
    data['followed'] = this.followed;
    data['avatarUrl'] = this.avatarUrl;
    data['accountStatus'] = this.accountStatus;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['birthday'] = this.birthday;
    data['userId'] = this.userId;
    data['userType'] = this.userType;
    data['nickname'] = this.nickname;
    data['signature'] = this.signature;
    data['description'] = this.description;
    data['detailDescription'] = this.detailDescription;
    data['avatarImgId'] = this.avatarImgId;
    data['backgroundImgId'] = this.backgroundImgId;
    data['backgroundUrl'] = this.backgroundUrl;
    data['authority'] = this.authority;
    data['mutual'] = this.mutual;
    data['expertTags'] = this.expertTags;
    data['experts'] = this.experts;
    data['djStatus'] = this.djStatus;
    data['vipType'] = this.vipType;
    data['remarkName'] = this.remarkName;
    data['backgroundImgIdStr'] = this.backgroundImgIdStr;
    data['avatarImgIdStr'] = this.avatarImgIdStr;
    data['avatarImgId_str'] = this.avatarImgIdStr;
    return data;
  }
}

class Creator {
  late bool defaultAvatar;
  late int province;
  late int authStatus;
  late bool followed;
  late String avatarUrl;
  late int accountStatus;
  late int gender;
  late int city;
  late int birthday;
  late int userId;
  late int userType;
  late String nickname;
  late String signature;
  late String description;
  late String detailDescription;
  late int avatarImgId;
  late int backgroundImgId;
  late String backgroundUrl;
  late int authority;
  late bool mutual;
  late Null expertTags;
  late Null experts;
  late int djStatus;
  late int vipType;
  late Null remarkName;
  late String backgroundImgIdStr;
  late String avatarImgIdStr;

  Creator(
      {required this.defaultAvatar,
      required this.province,
      required this.authStatus,
      required this.followed,
      required this.avatarUrl,
      required this.accountStatus,
      required this.gender,
      required this.city,
      required this.birthday,
      required this.userId,
      required this.userType,
      required this.nickname,
      required this.signature,
      required this.description,
      required this.detailDescription,
      required this.avatarImgId,
      required this.backgroundImgId,
      required this.backgroundUrl,
      required this.authority,
      required this.mutual,
      required this.expertTags,
      required this.experts,
      required this.djStatus,
      required this.vipType,
      required this.remarkName,
      required this.backgroundImgIdStr,
      required this.avatarImgIdStr});

  Creator.fromJson(Map<String, dynamic> json) {
    defaultAvatar = json['defaultAvatar'];
    province = json['province'];
    authStatus = json['authStatus'];
    followed = json['followed'];
    avatarUrl = json['avatarUrl'];
    accountStatus = json['accountStatus'];
    gender = json['gender'];
    city = json['city'];
    birthday = json['birthday'];
    userId = json['userId'];
    userType = json['userType'];
    nickname = json['nickname'];
    signature = json['signature'];
    description = json['description'];
    detailDescription = json['detailDescription'];
    avatarImgId = json['avatarImgId'];
    backgroundImgId = json['backgroundImgId'];
    backgroundUrl = json['backgroundUrl'];
    authority = json['authority'];
    mutual = json['mutual'];
    expertTags = json['expertTags'];
    experts = json['experts'];
    djStatus = json['djStatus'];
    vipType = json['vipType'];
    remarkName = json['remarkName'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    avatarImgIdStr = json['avatarImgIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['defaultAvatar'] = this.defaultAvatar;
    data['province'] = this.province;
    data['authStatus'] = this.authStatus;
    data['followed'] = this.followed;
    data['avatarUrl'] = this.avatarUrl;
    data['accountStatus'] = this.accountStatus;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['birthday'] = this.birthday;
    data['userId'] = this.userId;
    data['userType'] = this.userType;
    data['nickname'] = this.nickname;
    data['signature'] = this.signature;
    data['description'] = this.description;
    data['detailDescription'] = this.detailDescription;
    data['avatarImgId'] = this.avatarImgId;
    data['backgroundImgId'] = this.backgroundImgId;
    data['backgroundUrl'] = this.backgroundUrl;
    data['authority'] = this.authority;
    data['mutual'] = this.mutual;
    data['expertTags'] = this.expertTags;
    data['experts'] = this.experts;
    data['djStatus'] = this.djStatus;
    data['vipType'] = this.vipType;
    data['remarkName'] = this.remarkName;
    data['backgroundImgIdStr'] = this.backgroundImgIdStr;
    data['avatarImgIdStr'] = this.avatarImgIdStr;
    return data;
  }
}

class Tracks {
  late String name;
  late int id;
  late List<Ar> ar;
  late int pop;
  late int st;
  late String rt;
  late int fee;
  late int v;
  late String cf;
  late int dt;
  late String cd;
  late int no;
  late int ftype;
  late int djId;
  late int copyright;
  late int sId;
  late int mark;
  late int rtype;
  late int mst;
  late int cp;
  late int mv;
  late int publishTime;

  Tracks(
      {required this.name,
      required this.id,
      required this.ar,
      required this.pop,
      required this.st,
      required this.rt,
      required this.fee,
      required this.v,
      required this.cf,
      required this.dt,
      required this.cd,
      required this.no,
      required this.ftype,
      required this.djId,
      required this.copyright,
      required this.sId,
      required this.mark,
      required this.rtype,
      required this.mst,
      required this.cp,
      required this.mv,
      required this.publishTime});

  Tracks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['ar'] != null) {
      ar = <Ar>[];
      json['ar'].forEach((v) {
        ar.add(Ar.fromJson(v));
      });
    }
    pop = json['pop'];
    st = json['st'];
    rt = json['rt'];
    fee = json['fee'];
    v = json['v'];
    cf = json['cf'];
    dt = json['dt'];

    cd = json['cd'];
    no = json['no'];

    ftype = json['ftype'];
    djId = json['djId'];
    copyright = json['copyright'];
    sId = json['s_id'];
    mark = json['mark'];
    rtype = json['rtype'];
    mst = json['mst'];
    cp = json['cp'];
    mv = json['mv'];
    publishTime = json['publishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;

    if (this.ar != null) {
      data['ar'] = this.ar.map((v) => v.toJson()).toList();
    }

    data['pop'] = this.pop;
    data['st'] = this.st;
    data['rt'] = this.rt;
    data['fee'] = this.fee;
    data['v'] = this.v;
    data['cf'] = this.cf;
    data['dt'] = this.dt;
    data['cd'] = this.cd;
    data['no'] = this.no;
    data['ftype'] = this.ftype;
    data['djId'] = this.djId;
    data['copyright'] = this.copyright;
    data['s_id'] = this.sId;
    data['mark'] = this.mark;
    data['rtype'] = this.rtype;
    data['mst'] = this.mst;
    data['cp'] = this.cp;
    data['mv'] = this.mv;
    data['publishTime'] = this.publishTime;
    return data;
  }
}

class Ar {
  late int id;
  late String name;

  Ar({
    required this.id,
    required this.name,
  });

  Ar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}

class Privileges {
  late int id;
  late int fee;
  late int payed;
  late int st;
  late int pl;
  late int dl;
  late int sp;
  late int cp;
  late int subp;
  late bool cs;
  late int maxbr;
  late int fl;
  late bool toast;
  late int flag;
  late bool preSell;

  Privileges(
      {required this.id,
      required this.fee,
      required this.payed,
      required this.st,
      required this.pl,
      required this.dl,
      required this.sp,
      required this.cp,
      required this.subp,
      required this.cs,
      required this.maxbr,
      required this.fl,
      required this.toast,
      required this.flag,
      required this.preSell});

  Privileges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fee = json['fee'];
    payed = json['payed'];
    st = json['st'];
    pl = json['pl'];
    dl = json['dl'];
    sp = json['sp'];
    cp = json['cp'];
    subp = json['subp'];
    cs = json['cs'];
    maxbr = json['maxbr'];
    fl = json['fl'];
    toast = json['toast'];
    flag = json['flag'];
    preSell = json['preSell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['fee'] = this.fee;
    data['payed'] = this.payed;
    data['st'] = this.st;
    data['pl'] = this.pl;
    data['dl'] = this.dl;
    data['sp'] = this.sp;
    data['cp'] = this.cp;
    data['subp'] = this.subp;
    data['cs'] = this.cs;
    data['maxbr'] = this.maxbr;
    data['fl'] = this.fl;
    data['toast'] = this.toast;
    data['flag'] = this.flag;
    data['preSell'] = this.preSell;
    return data;
  }
}
