class YunCoinTask {
  late int code;

  late List<Data> data;

  static YunCoinTask fromJson(Map<String, dynamic> map) {
    YunCoinTask yunCoinTask = YunCoinTask();
    yunCoinTask.code = map['code'];
    yunCoinTask.data = []
      ..addAll((map['data'] as List).map((o) => Data.fromJson(o)));
    return yunCoinTask;
  }
}

class Data {
late int taskPoint;
late String taskName;
late String webPicUrl;
late String taskDescription;
late String link;
  static Data fromJson(Map<String, dynamic> map) {
    Data data = Data();
    data.taskPoint = map['taskPoint'];
    data.taskName = map['taskName'];
    data.webPicUrl = map['webPicUrl'];
    data.taskDescription = map['taskDescription'];
    data.link = map['link'];
    return data;
  }
}
