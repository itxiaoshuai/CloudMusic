class NewAlbum {
  int code;

  List<Album> albums;

  static NewAlbum fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    NewAlbum newAlbum = NewAlbum();
    newAlbum.code = map['code'];
    newAlbum.albums = []
      ..addAll((map['albums'] as List ?? []).map((o) => Album.fromJson(o)));
    return newAlbum;
  }
}

class Album {
  String name;
  String blurPicUrl;
  Artist artist;
  int publishTime;
  List<String> alias;

  static Album fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Album data = Album();
    data.name = map['name'];
    data.publishTime = map['publishTime'];
    data.blurPicUrl = map['blurPicUrl'];
    data.artist = Artist.fromJson(map['artist']);
    data.alias =  []
      ..addAll((map['alias'] as List ?? []).map((o) => o));
    return data;
  }
}

class Artist {
  String name;

  static Artist fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Artist data = Artist();
    data.name = map['name'];
    return data;
  }
}
