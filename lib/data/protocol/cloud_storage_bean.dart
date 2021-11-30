class CloudStorageBean {
  late int code;
  late String size;
  late String maxSize;
  late int count;
  late bool hasMore;
  late List<Data> data;

 static CloudStorageBean fromJson(Map<String, dynamic> map) {
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
  late SimpleSong simpleSong;
  late String songName;
  late String album;
  late String artist;

  static Data fromJson(Map<String, dynamic> map) {
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
  late String name;
  late int id;
  late int mv;
  static SimpleSong fromJson(Map<String, dynamic> map) {
    SimpleSong data = SimpleSong();
    data.name = map['name'];
    data.id = map['id'];
    data.mv = map['mv'];
    return data;
  }
}
