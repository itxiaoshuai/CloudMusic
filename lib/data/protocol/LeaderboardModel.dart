class LeaderBoardModel {
  int code;
  List<LeaderBoardList> list;

  LeaderBoardModel({this.code, this.list});

  LeaderBoardModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['list'] != null) {
      list = List<LeaderBoardList>();
      json['list'].forEach((v) {
        list.add(LeaderBoardList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['code'] = this.code;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class LeaderBoardList {
  String updateFrequency;
  String coverImgUrl;
  int trackCount;
  int userId;
  String toplistType;
  String name;
  String description;
  int playCount;
  bool ordered;
  int id;
  LeaderBoardList(
      {this.updateFrequency,
      this.ordered,
      this.coverImgUrl,
      this.trackCount,
      this.userId,
      this.playCount,
      this.description,
      this.name,
      this.toplistType,
      this.id});

  LeaderBoardList.fromJson(Map<String, dynamic> json) {
    updateFrequency = json['updateFrequency'];
    ordered = json['ordered'];
    coverImgUrl = json['coverImgUrl'];
    trackCount = json['trackCount'];
    userId = json['userId'];
    playCount = json['playCount'];
    description = json['description'];
    name = json['name'];
    toplistType = json['ToplistType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();

    data['updateFrequency'] = this.updateFrequency;
    data['ordered'] = this.ordered;
    data['coverImgUrl'] = this.coverImgUrl;
    data['trackCount'] = this.trackCount;
    data['userId'] = this.userId;
    data['playCount'] = this.playCount;
    data['description'] = this.description;
    data['name'] = this.name;
    data['ToplistType'] = this.toplistType;
    data['id'] = this.id;
    return data;
  }
}
