import 'dart:convert' show json;

class Lyric {
  late String lyric;
  late Duration startTime;
  late Duration endTime;
  late double offset;

  Lyric(this.lyric,
      {required this.startTime, this.endTime = Duration.zero, this.offset = 0});

  @override
  String toString() {
    return 'Lyric{lyric: $lyric, startTime: $startTime, endTime: $endTime}';
  }
}

class LyricData {
  late TransUser? transUser;
  late TransUser? lyricUser;
  late Lrc lrc;
  late Klyric klyric;
  late Tlyric tlyric;
  late int code;

  LyricData({
    required this.transUser,
    required this.lrc,
    required this.klyric,
    required this.tlyric,
    required this.code,
  });

  LyricData.fromJson(Map<String, dynamic> json) {
    transUser = (json['transUser'] != null ? TransUser.fromJson(json['transUser']) : null);
    lrc = Lrc.fromJson(json['lrc']);
    klyric = Klyric.fromJson(json['klyric']);
    tlyric = Tlyric.fromJson(json['tlyric']);
  }

  Map<String, dynamic> toJson() => {
        'transUser': transUser,
        'lrc': lrc,
        'klyric': klyric,
        'tlyric': tlyric,
        'code': code,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class LyricUser {
  late int id;
  late int status;
  late int demand;
  late int userid;
  late String nickname;
  late int uptime;

  LyricUser({
    required this.id,
    required this.status,
    required this.demand,
    required this.userid,
    required this.nickname,
    required this.uptime,
  });

  LyricUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    demand = json['demand'];
    userid = json['userid'];
    nickname = json['nickname'];
    uptime = json['uptime'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'demand': demand,
        'userid': userid,
        'nickname': nickname,
        'uptime': uptime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TransUser {
  late int id;
  late int status;
  late int demand;
  late int userid;
  late String nickname;
  late int uptime;

  TransUser({
    required this.id,
    required this.status,
    required this.demand,
    required this.userid,
    required this.nickname,
    required this.uptime,
  });

  TransUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    demand = json['demand'];
    userid = json['userid'];
    nickname = json['nickname'];
    uptime = json['uptime'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'demand': demand,
        'userid': userid,
        'nickname': nickname,
        'uptime': uptime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Lrc {
  late int version;
  late String lyric;

  Lrc({
    required this.version,
    required this.lyric,
  });

  Lrc.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    lyric = json['lyric'];
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'lyric': lyric,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Klyric {
  late int version;
  late Object lyric;

  Klyric({
    required this.version,
    required this.lyric,
  });

  Klyric.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    lyric = json['lyric'];
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'lyric': lyric,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Tlyric {
  late int version;
  late String lyric;

  Tlyric({
    required this.version,
    required this.lyric,
  });

  Tlyric.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    lyric = json['lyric'];
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'lyric': lyric,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
