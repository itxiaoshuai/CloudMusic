class YunCoinTask {
  int code;

  List<Data> data;

  static YunCoinTask fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    YunCoinTask yunCoinTask = YunCoinTask();
    yunCoinTask.code = map['code'];
    yunCoinTask.data = []
      ..addAll((map['data'] as List ?? []).map((o) => Data.fromJson(o)));
    return yunCoinTask;
  }
}

class Data {
  int taskPoint;
  String taskName;
  String webPicUrl;
  String taskDescription;
  String link;
  static Data fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Data data = Data();
    data.taskPoint = map['taskPoint'];
    data.taskName = map['taskName'];
    data.webPicUrl = map['webPicUrl'];
    data.taskDescription = map['taskDescription'];
    data.link = map['link'];
    return data;
  }
}
