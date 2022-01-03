class DailyRecommend {
  late int code;
  late List<Recommend> recommend;
  late Data data;

  static DailyRecommend fromJson(Map<String, dynamic> map) {
    DailyRecommend dailyRecommend = DailyRecommend();
    dailyRecommend.code = map['code'];
    // dailyRecommend.recommend = []..addAll(
    //     (map['data']['dailySongs'] as List).map((o) => Recommend.fromJson(o)));
    dailyRecommend.data = Data.fromJson(map['data']);
    return dailyRecommend;
  }
}

class Recommend {
  late String name;
  late int id;

  static Recommend fromJson(Map<String, dynamic> map) {
    Recommend recommend = Recommend();
    recommend.name = map['name'];
    recommend.id = map['id'];

    return recommend;
  }
}

class Data {
  late List<DailySongs> dailySongs;

  static Data fromJson(Map<String, dynamic> map) {
    Data data = Data();
    data.dailySongs = []..addAll(
        (map['dailySongs'] as List).map((o) => DailySongs.fromJson(o)));
    return data;
  }
}

class DailySongs {
  late String name;
  late int id;
  late List<Artists> artists;
  late int mv;
  late Al al;
  late List<Ar> ar;

  static DailySongs fromJson(Map<String, dynamic> map) {
    DailySongs song = DailySongs();
    song.name = map['name'];
    song.id = map['id'];
    song.mv = map['mv'];
    // song.artists = []
    //   ..addAll((map['artists'] as List).map((o) => Artists.fromJson(o)));
    song.al = Al.fromJson(map['al']);
    song.ar = []..addAll((map['ar'] as List).map((o) => Ar.fromJson(o)));
    return song;
  }
}

class Artists {
  late String name;
  late int id;

  static Artists fromJson(Map<String, dynamic> map) {
    Artists artists = Artists();
    artists.name = map['name'];
    artists.id = map['id'];

    return artists;
  }
}

class Ar {
  late String name;
  late int id;

  static Ar fromJson(Map<String, dynamic> map) {
    Ar ar = Ar();
    ar.name = map['name'];
    ar.id = map['id'];
    return ar;
  }
}

class Al {
  late String name;
  late int id;
  late String picUrl;

  static Al fromJson(Map<String, dynamic> map) {
    Al album = Al();
    album.name = map['name'];
    album.id = map['id'];
    album.picUrl = map['picUrl'];
    return album;
  }
}
