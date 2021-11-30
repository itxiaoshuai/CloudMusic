import 'package:cloud_music/data/protocol/artist.dart';

class NewAlbum {
  late int code;

  late  List<Album> albums;

  static NewAlbum fromJson(Map<String, dynamic> map) {
    NewAlbum newAlbum = NewAlbum();
    newAlbum.code = map['code'];
    newAlbum.albums = []
      ..addAll((map['albums'] as List).map((o) => Album.fromJson(o)));
    return newAlbum;
  }
}

class Album {
late String name;
late String blurPicUrl;
late Artist artist;
late int publishTime;
late List<String> alias;

  static Album fromJson(Map<String, dynamic> map) {
    Album data = Album();
    data.name = map['name'];
    data.publishTime = map['publishTime'];
    data.blurPicUrl = map['blurPicUrl'];
    data.artist = Artist.fromJson(map['artist']);
    data.alias =  []
      ..addAll((map['alias'] as List).map((o) => o));
    return data;
  }
}


