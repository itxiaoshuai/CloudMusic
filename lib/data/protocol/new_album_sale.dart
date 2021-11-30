class NewAlbumSale {
  late int code;

  late List<Album> products;

  static NewAlbumSale fromJson(Map<String, dynamic> map) {
    NewAlbumSale newAlbum = NewAlbumSale();
    newAlbum.code = map['code'];
    newAlbum.products = []
      ..addAll((map['products'] as List).map((o) => Album.fromJson(o)));
    return newAlbum;
  }
}

class Album {
  late String albumName;
  late String coverUrl;
  late String artistName;
  static Album fromJson(Map<String, dynamic> map) {
    Album data = Album();
    data.albumName = map['albumName'];
    data.coverUrl = map['coverUrl'];
    data.albumName = map['albumName'];
    return data;
  }
}
