class DailyRecommend {
  int code;
  List<Recommend> recommend;
  Data data;

  static DailyRecommend fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    DailyRecommend dailyRecommend = DailyRecommend();
    dailyRecommend.code = map['code'];
    dailyRecommend.recommend = []..addAll(
        (map['recommend'] as List ?? []).map((o) => Recommend.fromJson(o)));
    dailyRecommend.data = Data.fromJson(map['data']);
    return dailyRecommend;
  }
}

class Recommend {
  String name;
  int id;

  static Recommend fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Recommend recommend = Recommend();
    recommend.name = map['name'];
    recommend.id = map['id'];

    return recommend;
  }
}

class Data {
  List<DailySongs> dailySongs;

  static Data fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Data data = Data();
    data.dailySongs = []..addAll(
        (map['dailySongs'] as List ?? []).map((o) => DailySongs.fromJson(o)));
    return data;
  }
}

class DailySongs {
  String name;
  int id;
  List<Artists> artists;
  int mvid;
  Al al;
  List<Ar> ar;

  static DailySongs fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    DailySongs song = DailySongs();
    song.name = map['name'];
    song.id = map['id'];
    song.mvid = map['mvid'];
    song.artists = []
      ..addAll((map['artists'] as List ?? []).map((o) => Artists.fromJson(o)));
    song.al = Al.fromJson(map['album']);
    song.ar = []..addAll((map['ar'] as List ?? []).map((o) => Ar.fromJson(o)));
    return song;
  }
}

class Artists {
  String name;
  int id;

  static Artists fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Artists artists = Artists();
    artists.name = map['name'];
    artists.id = map['id'];

    return artists;
  }
}

class Ar {
  String name;
  int id;

  static Ar fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Ar ar = Ar();
    ar.name = map['name'];
    ar.id = map['id'];
    return ar;
  }
}

class Al {
  String name;
  int id;
  String picUrl;

  static Al fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Al album = Al();
    album.name = map['name'];
    album.id = map['id'];
    album.picUrl = map['picUrl'];
    return album;
  }
}
