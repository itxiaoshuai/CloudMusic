import 'dart:convert' show json;
import 'package:flutter/foundation.dart';

class Lyric {
  String lyric;
  Duration startTime;
  Duration endTime;
  double offset;

  Lyric(this.lyric, {this.startTime, this.endTime, this.offset});

  @override
  String toString() {
    return 'Lyric{lyric: $lyric, startTime: $startTime, endTime: $endTime}';
  }
}

class LyricData {
  TransUser transUser;
  TransUser lyricUser;
  Lrc lrc;
  Klyric klyric;
  Tlyric tlyric;
  int code;

  LyricData({
    this.transUser,
    this.lrc,
    this.klyric,
    this.tlyric,
    this.code,
  });

  LyricData.fromJson(Map<String, dynamic> json) {
    transUser =
        json['transUser'] != null ? TransUser.fromJson(json['transUser']) : null;
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
  int id;
  int status;
  int demand;
  int userid;
  String nickname;
  int uptime;

  LyricUser({
    this.id,
    this.status,
    this.demand,
    this.userid,
    this.nickname,
    this.uptime,
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
  int id;
  int status;
  int demand;
  int userid;
  String nickname;
  int uptime;

  TransUser({
    this.id,
    this.status,
    this.demand,
    this.userid,
    this.nickname,
    this.uptime,
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
  int version;
  String lyric;

  Lrc({
    this.version,
    this.lyric,
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
  int version;
  Object lyric;

  Klyric({
    this.version,
    this.lyric,
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
  int version;
  String lyric;

  Tlyric({
    this.version,
    this.lyric,
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
