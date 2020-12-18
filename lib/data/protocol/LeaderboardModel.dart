import 'package:flutter/cupertino.dart';

class LeaderBoardModel {
  int code;
  List<LeaderBoardList> list;

  static LeaderBoardModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    LeaderBoardModel newsBean = LeaderBoardModel();
    newsBean.code = map['code'];
    newsBean.list = List()
      ..addAll(
          (map['list'] as List ?? []).map((o) => LeaderBoardList.fromJson(o)));
    return newsBean;
  }
}

class LeaderBoardList {
  String updateFrequency;
  String description;
  String name;
  int playCount;
  int id;
  String coverImgUrl;
  List<Track> tracks;

  static LeaderBoardList fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    LeaderBoardList product = LeaderBoardList();
    product.updateFrequency = map['updateFrequency'];
    product.description = map['description'];
    product.name = map['name'];
    product.playCount = map['playCount'];
    product.id = map['id'];
    product.coverImgUrl = map['coverImgUrl'];
    product.tracks = List()
      ..addAll((map['tracks'] as List ?? []).map((o) => Track.fromJson(o)));

    return product;
  }
}

class Track {
  String first;
  String second;

  static Track fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Track track = Track();
    track.first = map['first'];
    track.second = map['second'];
    return track;
  }
}
