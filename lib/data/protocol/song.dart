class Song {
  late int id; // 歌曲id
  late String name; // 歌曲名称
  late String artists; // 演唱者
  late String picUrl; // 歌曲图片

  Song(this.id, {required this.name, required this.artists, required this.picUrl});

  Song.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        artists = json['artists'],
        picUrl = json['picUrl'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'artists': artists,
        'picUrl': picUrl,
      };

  @override
  String toString() {
    return 'Song{id: $id, name: $name, artists: $artists}';
  }
}
