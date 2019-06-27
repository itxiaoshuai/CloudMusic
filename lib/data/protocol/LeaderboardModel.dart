class LeaderBoardModel {
  String updateFrequency; //每天更新
  String coverImgUrl;

  @override
  String toString() {
    return 'LeaderBoardModel{updateFrequency: $updateFrequency, coverImgUrl: $coverImgUrl, name: $name}';
  }

  String name;

  LeaderBoardModel(this.updateFrequency, this.coverImgUrl, this.name);

  LeaderBoardModel.fromJson(Map<String, dynamic> json)
      : updateFrequency = json['updateFrequency'],
        name = json['name'],
        coverImgUrl = json['coverImgUrl'];

  Map<String, dynamic> toJson() => {
        'updateFrequency': updateFrequency,
        'name': name,
        'coverImgUrl': coverImgUrl,
      };


}
