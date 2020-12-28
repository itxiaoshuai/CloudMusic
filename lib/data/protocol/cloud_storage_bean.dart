class CloudStorageBean {
  int code;
  String size;
  String maxSize;
  int count;
  bool hasMore;
  List<Data> data;

 static CloudStorageBean fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    CloudStorageBean cloudStorageBean = CloudStorageBean();
    cloudStorageBean.code = map['code'];
    cloudStorageBean.size = map['size'];
    cloudStorageBean.maxSize = map['maxSize'];
    cloudStorageBean.count = map['count'];
    cloudStorageBean.hasMore = map['hasMore'];
    if (map['data'] != null) {
      cloudStorageBean.data = <Data>[];
      map['data'].forEach((v) {
        cloudStorageBean.data.add(Data.fromJson(v));
      });
    }

    return cloudStorageBean;
  }
}

class Data {
  SimpleSong simpleSong;
  String songName;
  String album;
  String artist;

  static Data fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Data data = Data();
    if (map['simpleSong'] != null) {
      data.simpleSong = SimpleSong.fromJson(map['simpleSong']);
    }

    data.songName = map['songName'];
    data.album = map['album'];
    data.artist = map['artist'];
    return data;
  }
}

class SimpleSong {
  String name;
  int id;
  int mv;
  static SimpleSong fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    SimpleSong data = SimpleSong();
    data.name = map['name'];
    data.id = map['id'];
    data.mv = map['mv'];
    return data;
  }
}
