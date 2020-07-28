import 'package:flutter/material.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/data/protocol/user_detail_bean.dart';
import 'package:flutter_app/net/huyi_android_api.dart';

class TabMusic extends StatefulWidget {
  ///用户ID
  final UserDetail userDetail;

  const TabMusic({Key key, @required this.userDetail}) : super(key: key);

  @override
  _TabMusicState createState() => _TabMusicState();
}

class _TabMusicState extends State<TabMusic> {
  List<PlaylistDetail> mListData = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Column(
            children: mListData
                .map((element) => Stack(children: <Widget>[
                      ListTile(
                        title: Text(element.name),
                        subtitle: Text('Provider of milk'),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(element.coverImgUrl),
                        ),
                      )
                    ]))
                .toList(),
          ),
          Column(
            children: [
              Row(
                children: [
                  Text('基本信息'),
                  Text('更多信息'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> initData() async {
    Map<String, dynamic> formData = {
      'uid': widget.userDetail.profile.userId,
    };
    var response = await http.get('/user/playlist', queryParameters: formData);

//    playlistDetail = PlaylistDetail.fromJson(response.data['playlist']);
    mListData = (response.data["playlist"] as List)
        .cast<Map>()
        .map((e) => PlaylistDetail.fromJson(e))
        .toList();
    print(mListData.length);

    setState(() {});
  }
}
