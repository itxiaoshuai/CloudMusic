class LeaderBoardDetailModel {
  Playlist playlist;
  int code;

  LeaderBoardDetailModel({
    this.playlist,
    this.code,
  });

  LeaderBoardDetailModel.fromJson(Map<String, dynamic> json) {
    playlist =
        json['playlist'] != null ? Playlist.fromJson(json['playlist']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.playlist != null) {
      data['playlist'] = this.playlist.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Playlist {
  List<Subscribers> subscribers;
  bool subscribed;
  Creator creator;
  List<Tracks> tracks;
  int backgroundCoverId;
  int trackUpdateTime;
  int userId;
  bool highQuality;
  int specialType;
  int updateTime;
  int trackCount;
  String commentThreadId;
  int playCount;
  int createTime;
  int trackNumberUpdateTime;
  int coverImgId;
  String coverImgUrl;
  int adType;
  int privacy;
  bool newImported;
  int subscribedCount;
  int cloudTrackCount;
  String description;
  bool ordered;
  int status;
  String name;
  int id;
  int shareCount;
  String coverImgIdStr;
  String toplistType;
  int commentCount;

  Playlist(
      {this.subscribers,
      this.subscribed,
      this.creator,
      this.tracks,
      this.backgroundCoverId,
      this.trackUpdateTime,
      this.userId,
      this.highQuality,
      this.specialType,
      this.updateTime,
      this.trackCount,
      this.commentThreadId,
      this.playCount,
      this.createTime,
      this.trackNumberUpdateTime,
      this.coverImgId,
      this.coverImgUrl,
      this.adType,
      this.privacy,
      this.newImported,
      this.subscribedCount,
      this.cloudTrackCount,
      this.description,
      this.ordered,
      this.status,
      this.name,
      this.id,
      this.shareCount,
      this.coverImgIdStr,
      this.toplistType,
      this.commentCount});

  Playlist.fromJson(Map<String, dynamic> json) {
    if (json['subscribers'] != null) {
      subscribers = <Subscribers>[];
      json['subscribers'].forEach((v) {
        subscribers.add(Subscribers.fromJson(v));
      });
    }
    subscribed = json['subscribed'];
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
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
    if (this.subscribers != null) {
      data['subscribers'] = this.subscribers.map((v) => v.toJson()).toList();
    }
    data['subscribed'] = this.subscribed;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    if (this.tracks != null) {
      data['tracks'] = this.tracks.map((v) => v.toJson()).toList();
    }

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
  bool defaultAvatar;
  int province;
  int authStatus;
  bool followed;
  String avatarUrl;
  int accountStatus;
  int gender;
  int city;
  int birthday;
  int userId;
  int userType;
  String nickname;
  String signature;
  String description;
  String detailDescription;
  int avatarImgId;
  int backgroundImgId;
  String backgroundUrl;
  int authority;
  bool mutual;
  Null expertTags;
  Null experts;
  int djStatus;
  int vipType;
  Null remarkName;
  String backgroundImgIdStr;
  String avatarImgIdStr;

  Subscribers({
    this.defaultAvatar,
    this.province,
    this.authStatus,
    this.followed,
    this.avatarUrl,
    this.accountStatus,
    this.gender,
    this.city,
    this.birthday,
    this.userId,
    this.userType,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.avatarImgId,
    this.backgroundImgId,
    this.backgroundUrl,
    this.authority,
    this.mutual,
    this.expertTags,
    this.experts,
    this.djStatus,
    this.vipType,
    this.remarkName,
    this.backgroundImgIdStr,
    this.avatarImgIdStr,
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
  bool defaultAvatar;
  int province;
  int authStatus;
  bool followed;
  String avatarUrl;
  int accountStatus;
  int gender;
  int city;
  int birthday;
  int userId;
  int userType;
  String nickname;
  String signature;
  String description;
  String detailDescription;
  int avatarImgId;
  int backgroundImgId;
  String backgroundUrl;
  int authority;
  bool mutual;
  Null expertTags;
  Null experts;
  int djStatus;
  int vipType;
  Null remarkName;
  String backgroundImgIdStr;
  String avatarImgIdStr;

  Creator(
      {this.defaultAvatar,
      this.province,
      this.authStatus,
      this.followed,
      this.avatarUrl,
      this.accountStatus,
      this.gender,
      this.city,
      this.birthday,
      this.userId,
      this.userType,
      this.nickname,
      this.signature,
      this.description,
      this.detailDescription,
      this.avatarImgId,
      this.backgroundImgId,
      this.backgroundUrl,
      this.authority,
      this.mutual,
      this.expertTags,
      this.experts,
      this.djStatus,
      this.vipType,
      this.remarkName,
      this.backgroundImgIdStr,
      this.avatarImgIdStr});

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
  String name;
  int id;
  List<Ar> ar;

  int pop;
  int st;
  String rt;
  int fee;
  int v;

  String cf;

  int dt;

  String cd;
  int no;

  int ftype;
  int djId;
  int copyright;
  int sId;
  int mark;
  int rtype;

  int mst;
  int cp;
  int mv;
  int publishTime;

  Tracks(
      {this.name,
      this.id,
      this.ar,
      this.pop,
      this.st,
      this.rt,
      this.fee,
      this.v,
      this.cf,
      this.dt,
      this.cd,
      this.no,
      this.ftype,
      this.djId,
      this.copyright,
      this.sId,
      this.mark,
      this.rtype,
      this.mst,
      this.cp,
      this.mv,
      this.publishTime});

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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}

class Privileges {
  int id;
  int fee;
  int payed;
  int st;
  int pl;
  int dl;
  int sp;
  int cp;
  int subp;
  bool cs;
  int maxbr;
  int fl;
  bool toast;
  int flag;
  bool preSell;

  Privileges(
      {this.id,
      this.fee,
      this.payed,
      this.st,
      this.pl,
      this.dl,
      this.sp,
      this.cp,
      this.subp,
      this.cs,
      this.maxbr,
      this.fl,
      this.toast,
      this.flag,
      this.preSell});

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
