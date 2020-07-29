import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/CommonLoading.dart';
import 'package:flutter_app/base/res/gaps.dart';
import 'package:flutter_app/base/res/styles.dart';
import 'package:flutter_app/data/api/apis.dart';
import 'package:flutter_app/data/protocol/banner_model.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/pages/find/widget/FindBanner.dart';
import 'package:flutter_app/pages/find/widget/LearnInkWell.dart';
import 'package:flutter_app/pages/find/widget/SpinKitWaveType.dart';
import 'package:flutter_app/pages/leaderboard/LeaderboardPage.dart';
import 'package:flutter_app/pages/my/PageMy.dart';
import 'package:flutter_app/pages/page_songlist.dart';
import 'package:flutter_app/pages/radio/page_radio.dart';
import 'package:flutter_app/pages/user/page_user_detail.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';
import 'package:flutter_app/widget/base_song_img_item.dart';

import 'FutureBuilderPage.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  List<Banners> _bannerData = [];
  List widgets = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getHttp();
    getSongListRecommend();
    super.initState();
  }

  Future getHttp() async {
    var dio = Dio();
    var response =
        await dio.get("http://www.mocky.io/v2/5cee0154300000592c6e9825");

    List<Banners> banners = BannerModel.fromJson(response.data).banners;

    _bannerData = banners;
    if (banners != null && mounted) {
      setState(() {
        _bannerData = banners;
      });
    }
  }

  Future getSongListRecommend() async {
    Map<String, dynamic> formData = {
      'limit': 6,
    };
    var response = await Http()
        .get(MusicApi.SONGLISTDRECOMMEND, queryParameters: formData);
    print(response);
    List rows = response.data['result'];
    widgets = rows;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getHttp();
      },
//      child: CustomScrollView(slivers: _listWidget(context)),
      child: ListView(
        children: <Widget>[
          FindBanner(bannerData: _bannerData),
          _buildMenu(context),
          Divider(
            height: 1,
            color: Colors.grey[300],
          ),
          _Header("推荐歌单", () {}),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widgets.map<Widget>((p) {
                return Row(
                  children: [
                    BaseImgItem(
                      id: p['id'],
                      width: 120,
                      playCount: p['playCount'],
                      img: p['picUrl'],
                      describe: p['name'],
                    ),
                    Gaps.hGap8,
                  ],
                );
              }).toList(),
            ),
          ),
          NewSongAndDiscWidget(),
        ],
      ),
    );
  }
}

List<int> getDataList(int count) {
  List<int> list = [];
  for (int i = 0; i < count; i++) {
    list.add(i);
  }
  return list;
}

List<Widget> getWidgetList(List list) {
  return getDataList(list.length)
      .map((item) => getItemContainer(list[item]['picUrl']))
      .toList();
}

Widget getItemContainer(String picUrl) {
  return ListItemCustom(img: picUrl);
}

class _Header extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.only(top: 10, bottom: 10),
      margin: EdgeInsets.only(top: 20, bottom: 6),
      child: Stack(
        children: <Widget>[
          Positioned(
              child: Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          )),
          Positioned(
              right: 15,
              child: Container(
                padding: EdgeInsets.only(top: 2, bottom: 2, left: 6, right: 6),
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey, width: 0.5),
                  // 边色与边宽度

                  // 底色
                  //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                  shape: BoxShape.rectangle,
                  // 默认值也是矩形
                  borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                ),
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  '歌单广场',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              )),
        ],
      ),
//      child: Row(
//        mainAxisAlignment:   MainAxisAlignment.end,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Padding(padding: EdgeInsets.only(left: 8)),
//          Text(
//            text,
//            style: Theme.of(context)
//                .textTheme
//                .subhead
//                .copyWith(fontWeight: FontWeight.w800),
//          ),
//          Icon(Icons.chevron_right),
//        ],
//      ),
    );
  }

  _Header(this.text, this.onTap);
}

Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Map> songlist = (snapshot.data["result"] as List).cast();
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
//      children: getWidgetList(songlist),
      children: songlist.map<Widget>((p) {
        return ListItemCustom(
          img: p['picUrl'],
          album: p,
        );
      }).toList(),
    ),
  );
}

///snapshot就是_calculation在时间轴上执行过程的状态快照
Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
  switch (snapshot.connectionState) {
    case ConnectionState.none:
      print('还没有开始网络请求');
      return Text('还没有开始网络请求');
    case ConnectionState.active:
      print('active');
      return Text('ConnectionState.active');
    case ConnectionState.waiting:
      print('waiting');
      return Center(child: SpinKitWave(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.red : Colors.green,
            ),
          );
        },
      ));
    case ConnectionState.done:
      print('done');
      if (snapshot.hasError) return Text('Error: ${snapshot.error}');
      return _createListView(context, snapshot);

    default:
      return null;
  }
}

_buildMenu(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 15, bottom: 15),
//            color: Colors.green,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
        children: [
          InkWell(
            child: ListItem(
                image: "images/find/t_dragonball_icn_daily.png", text: "每日推荐"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return NestedScrollDemoPage();
              }));
            },
          ),
          InkWell(
            child: ListItem(
                image: "images/find/t_dragonball_icn_playlist.png", text: "歌单"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return SongListPage();
              }));
            },
          ),
          InkWell(
            child: ListItem(
                image: "images/find/t_dragonball_icn_rank.png", text: "排行榜"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return LeaderBoardPage();
              }));
            },
          ),
          InkWell(
            child: ListItem(
                image: "images/find/t_dragonball_icn_radio.png", text: "电台"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return RadioPage();
              }));
            },
          ),
          InkWell(
            child: ListItem(
                image: "images/find/t_dragonball_icn_look.png", text: "直播"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return UserDetailPage();
              }));
            },
          ),
        ]),
  );
}

class ListItem extends StatelessWidget {
  final String text;
  final String image;

  ListItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 40.0,
          decoration: BoxDecoration(
            //圆形渐变
            color: Colors.white,
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [
              Colors.redAccent,
              Colors.redAccent,
              Colors.red,
            ]),
          ),
          child: Image.asset(
            image,
            color: Colors.white,
            width: 50,
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 5), //上边距
            child: Text(text,
                style: TextStyle(
                  fontSize: 12,
                )))
      ],
    );
  }
}

//新歌和新碟
class NewSongAndDiscWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewSongAndDiscWidgetState();
  }
}

class NewSongAndDiscWidgetState extends State<NewSongAndDiscWidget> {
  bool isNewSong = true; //新歌
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Container(
//            color: Colors.blue,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Text(
                    '新歌',
                    style: isNewSong
                        ? TextStyles.textBoldDark16
                        : TextStyles.textDark16,
                  ),
                  onTap: () {
                    isNewSong = !isNewSong;
                    setState(() {});
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  color: Colors.grey,
                  height: 15,
                  width: 1,
                ),
                InkWell(
                  child: Text(
                    '新碟',
                    style: isNewSong
                        ? TextStyles.textDark16
                        : TextStyles.textBoldDark16,
                  ),
                  onTap: () {
                    isNewSong = !isNewSong;
                    setState(() {});
                  },
                ),
                Spacer(),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Text(
                    isNewSong ? '更多新歌' : '更多新碟',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle, // 默认值也是矩形
                    borderRadius: BorderRadius.circular((20.0)), // 圆角度
                    border: Border.all(color: Colors.grey, width: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: ListView(
              children: [
                Container(
                  height: 100,
                  child: Row(
                    children: [
                      Center(
                          child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(circular),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:
                                'https://p1.music.126.net/T_u5O7KbDpcnOSLIa8OEtw==/109951165122813288.jpg',
                            placeholder: (context, url) => ProgressView(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      )),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                      child: Center(
                                    child: Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Text(
                                        'xxxxx',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )),
                                ),
                                Expanded(
                                  child: Container(
                                      child: Center(
                                    child: Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Text(
                                        'xxxxx',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )),
                                ),
                                Expanded(
                                  child: Container(
                                      child: Center(
                                    child: Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Text(
                                        'xxxxx',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )),
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
