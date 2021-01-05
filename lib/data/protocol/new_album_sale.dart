class NewAlbumSale {
  int code;

  List<Album> products;

  static NewAlbumSale fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    NewAlbumSale newAlbum = NewAlbumSale();
    newAlbum.code = map['code'];
    newAlbum.products = []
      ..addAll((map['products'] as List ?? []).map((o) => Album.fromJson(o)));
    return newAlbum;
  }
}

class Album {
  String albumName;
  String coverUrl;
  String artistName;
  static Album fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Album data = Album();
    data.albumName = map['albumName'];
    data.coverUrl = map['coverUrl'];
    data.albumName = map['albumName'];
    return data;
  }
}
