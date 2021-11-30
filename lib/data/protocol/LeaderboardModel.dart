class LeaderBoardModel {
  late int code;
  late List<LeaderBoardList> list;

  static LeaderBoardModel fromJson(Map<String, dynamic> map) {
    LeaderBoardModel newsBean = LeaderBoardModel();
    newsBean.code = map['code'];
    newsBean.list = []..addAll(
        (map['list'] as List).map((o) => LeaderBoardList.fromJson(o)));
    return newsBean;
  }
}

class LeaderBoardList {
  late String updateFrequency;
  late String description;
  late String name;
  late int playCount;
  late int id;
  late String coverImgUrl;
  late List<Track> tracks;

  static LeaderBoardList fromJson(Map<String, dynamic> map) {
    LeaderBoardList product = LeaderBoardList();
    product.updateFrequency = map['updateFrequency'];
    product.description = map['description'];
    product.name = map['name'];
    product.playCount = map['playCount'];
    product.id = map['id'];
    product.coverImgUrl = map['coverImgUrl'];
    product.tracks = []
      ..addAll((map['tracks'] as List).map((o) => Track.fromJson(o)));

    return product;
  }
}

class Track {
  late String first;
  late String second;

  static Track fromJson(Map<String, dynamic> map) {
    Track track = Track();
    track.first = map['first'];
    track.second = map['second'];
    return track;
  }
}
