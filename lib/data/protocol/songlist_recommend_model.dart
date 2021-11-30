///歌单推荐

class SongListRecommendModel {
  late bool hasTaste;
  late int code;
  late int category;
  late List<Result> result;

  SongListRecommendModel(
      {required this.hasTaste,
      required this.code,
      required this.category,
      required this.result});

  SongListRecommendModel.fromJson(Map<String, dynamic> json) {
    hasTaste = json['hasTaste'];
    code = json['code'];
    category = json['category'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['hasTaste'] = this.hasTaste;
    data['code'] = this.code;
    data['category'] = this.category;
    data['result'] = this.result.map((v) => v.toJson()).toList();
    return data;
  }
}

class Result {
  late int id;
  late int type;
  late String name;
  late String copywriter;
  late String picUrl;
  late bool canDislike;
  late int playCount;
  late int trackCount;
  late bool highQuality;
  late String alg;

  Result(
      {required this.id,
      required this.type,
      required this.name,
      required this.copywriter,
      required this.picUrl,
      required this.canDislike,
      required this.playCount,
      required this.trackCount,
      required this.highQuality,
      required this.alg});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    copywriter = json['copywriter'];
    picUrl = json['picUrl'];
    canDislike = json['canDislike'];
    playCount = json['playCount'];
    trackCount = json['trackCount'];
    highQuality = json['highQuality'];
    alg = json['alg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['copywriter'] = this.copywriter;
    data['picUrl'] = this.picUrl;
    data['canDislike'] = this.canDislike;
    data['playCount'] = this.playCount;
    data['trackCount'] = this.trackCount;
    data['highQuality'] = this.highQuality;
    data['alg'] = this.alg;
    return data;
  }
}
