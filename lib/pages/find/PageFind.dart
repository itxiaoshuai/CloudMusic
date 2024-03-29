import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/data/protocol/BannerBean.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/data/api/apis.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/pages/find/widget/FindBanner.dart';
import 'package:cloud_music/pages/my/PageMy.dart';
import 'package:cloud_music/widget/ListItemCustom.dart';
import 'package:cloud_music/widget/base_song_img_item.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../../r.dart';
import 'package:cloud_music/widget/HomeDrawer.dart';
import 'box_find_recommend.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage>
    with AutomaticKeepAliveClientMixin<FindPage> {
  @override
  bool get wantKeepAlive => true; //需要返回true
  List<BannerBean> _bannerData = [];
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

    List<BannerBean> banners = BannerList.fromJson(response.data).banners;

    _bannerData = banners;
    if (mounted) {
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

  List imageList = [
    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=500542857,4026327610&fm=26&gp=0.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    var i = 1; //排行榜名次
    return Container(
      child: Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          elevation: 0,
          primary: true,
          leading: IconButton(
              icon: Icon(
                Icons.dehaze,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
          //为false的时候会影响leading，actions、titile组件，导致向上偏移
          textTheme: TextTheme(//设置AppBar上面各种字体主题色
//            title: TextStyle(color: Colors.red),
              ),
          actionsIconTheme: IconThemeData(color: Colors.blue, opacity: 0.6),
          //设置导航右边图标的主题色，此时iconTheme对于右边图标颜色会失效
          iconTheme: IconThemeData(color: Colors.black, opacity: 0.6),
          //设置AppBar上面Icon的主题颜色
          brightness: Brightness.light,
          //设置导航条上面的状态栏显示字体颜色
          backgroundColor: Colors.white,
          //设置背景颜色
//          shape: CircleBorder(side: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid)),//设置appbar形状
//          automaticallyImplyLeading: true,//在leading为null的时候失效
          centerTitle: true,
          title: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Material(
              color: Colors.grey[100],
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteName.PAGE_SEARCH);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  height: 45.0,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        size: 25,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          '大家都在搜王一博',
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          actions: <Widget>[
            IconButton(
                icon: Image.asset(
                  'images/drawer_music.png',
                  color: Colors.black,
                ),
                onPressed: () {}),
          ],
        ),
        body: ListView(
          children: <Widget>[
            FindBanner(bannerData: _bannerData),
            _buildMenu(context),
            Gaps.line,
            // Container(
            //   height: 100, // 高度
            //   child: Swiper(
            //     itemBuilder: (BuildContext context, int index) {
            //       return Image.network(
            //         "http://via.placeholder.com/288x188",
            //         fit: BoxFit.fill,
            //       );
            //     },
            //     itemCount: 3,
            //     viewportFraction: 0.333,
            //     scale: 0.4,
            //   ),
            // ),
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
            BoxFindRecommend(
              text: "推荐歌单",
              route: RouteName.PAGE_DAILY_RECOMMEND,
            ),

            Container(
              // color: Colors.redAccent,
//            padding: EdgeInsets.only(left: 15, right: 0),
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Gaps.hGap15,
                  Row(
                    children: widgets.map<Widget>((p) {
                      i++;
                      return Row(
                        children: [
                          BaseImgItem(
                            id: p['id'],
                            width: 120,
                            playCount: p['playCount'],
                            img: p['picUrl'],
                            describe: p['name'],
                          ),
                          i == widgets.length + 1 ? Gaps.hGap15 : Gaps.hGap8,
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              color: Colors.grey[300],
            ),
            NewSongAndDiscWidget(),
            BoxFindRecommend(
              text: "音乐日历",
              route: RouteName.PAGE_DAILY_RECOMMEND,
            ),
          ],
        ),
      ),
    );

    return RefreshIndicator(
      onRefresh: () async {
        getHttp();
      },
//      child: CustomScrollView(slivers: _listWidget(context)),
      child: ListView(
        children: <Widget>[
          FindBanner(bannerData: _bannerData),
          _buildMenu(context),
          Container(
            height: 100, // 高度
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "http://via.placeholder.com/288x188",
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              viewportFraction: 0.333,
              scale: 0.4,
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[300],
          ),
          Container(
//            padding: EdgeInsets.only(left: 15, right: 0),
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Gaps.hGap15,
                Row(
                  children: widgets.map<Widget>((p) {
                    i++;
                    return Row(
                      children: [
                        BaseImgItem(
                          id: p['id'],
                          width: 120,
                          playCount: p['playCount'],
                          img: p['picUrl'],
                          describe: p['name'],
                        ),
                        i == widgets.length + 1 ? Gaps.hGap15 : Gaps.hGap8,
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          NewSongAndDiscWidget(),
        ],
      ),
    );
    return super.build(context);
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
  return ListItemCustom(img: picUrl, album: {},);
}

_buildMenu(BuildContext context) {
  var i = 1; //排行榜名次

  return Container(
    // color: Colors.green,
    height: 100,
    padding: EdgeInsets.only(top: 15, bottom: 15),
    child: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        children: [
          Gaps.hGap15,
          Expanded(
            child: Container(
              child: Row(
                children: videoCategoryList.map((e) {
                  i++;

                  return Row(
                    children: [
                      ListItem(
                        image: e.img,
                        text: e.title,
                        route: e.path,
                      ),
                      i == widgets.length + 1 ? Gaps.hGap15 : Gaps.hGap15,
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ]),
  );
}

class ListItem extends StatelessWidget {
  final String text;
  final String image;
  final String route;

  ListItem({required this.image, required this.text, required this.route});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (text == '数字专辑') {
            var arguments = {
              "https://music.163.com/v/m/album/poly/detail",
              "数字专辑"
            };
            Map<String, dynamic> data = new Map<String, dynamic>();
            data['url'] = "https://music.163.com/v/m/album/poly/detail";
            data['title'] = "数字专辑";
            Navigator.of(context).pushNamed(route, arguments: data);
          } else {
            Navigator.of(context).pushNamed(route);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 45.0,
                  decoration: BoxDecoration(
                    //圆形渐变
                    color: Colors.pink[50]!.withOpacity(0.8),
                    shape: BoxShape.circle,
                    // gradient: const LinearGradient(colors: [
                    //   Colors.redAccent,
                    //   Colors.redAccent,
                    //   Colors.red,
                    // ]),
                  ),
                  child: Image.asset(
                    image,
                    color: Colors.red,
                    width: 50,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: text == '每日推荐'
                      ? Text(
                          '${DateUtil.formatDate(DateTime.now(), format: 'd')}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(''),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 5), //上边距
                child: Text(text,
                    style: TextStyle(
                      fontSize: 12,
                    )))
          ],
        ),
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 45.0,
              decoration: BoxDecoration(
                //圆形渐变
                color: Colors.pink[50]!.withOpacity(0.8),
                shape: BoxShape.circle,
                // gradient: const LinearGradient(colors: [
                //   Colors.redAccent,
                //   Colors.redAccent,
                //   Colors.red,
                // ]),
              ),
              child: Image.asset(
                image,
                color: Colors.red,
                width: 50,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: text == '每日推荐'
                  ? Text(
                      '${DateUtil.formatDate(DateTime.now(), format: 'd')}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(''),
            )
          ],
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
  List _newSong = [];
  List _newAlbum = [];

  @override
  void initState() {
    getNewSongList();
    getNewAlbumList();
    super.initState();
  }

  Future getNewSongList() async {
    Map<String, dynamic> formData = {
      'limit': 6,
    };
    var response =
        await Http().get(MusicApi.NewSong, queryParameters: formData);
    print(response);
    List rows = response.data['result'];
    _newSong = rows;
    setState(() {});
  }

  //新碟
  Future getNewAlbumList() async {
//    Map<String, dynamic> formData = {
//      'limit': 6,
//    };
    var response = await Http().get(MusicApi.NewAlbum);
    print(response);
    List rows = response.data['albums'];
    _newAlbum = rows;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    print('width is $width; height is $height');
    String getText(Map tracks) {
      StringBuffer stringBuffer = new StringBuffer();

      String name = tracks['song']['album']['name'];
      stringBuffer.write(name);
      List artists = tracks['song']['album']['artists'];
      var length = artists.length;
      if (length > 0) {
        stringBuffer.write('-');
      }
      artists.forEach((item) {
        if (length == 1) {
          stringBuffer.write(item['name']);
        }
        if (length > 1) {
          stringBuffer.write(item['name']);
          stringBuffer.write('/');
        }

        length--;
      });

      return stringBuffer.toString();
    }

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
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
          Visibility(
            visible: isNewSong,
            child: Container(
              height: 200,
              child: PageView(
                controller: PageController(
                    initialPage: 0, viewportFraction: (width - 30) / width),
                children: TestDatas.map((color) {
                  return Container(
                    width: 100,
                    height: 200,
//                  color: color,
                    child: Column(
                      children: _newSong.sublist(0, 3).map((e) {
                        return Container(
                          height: 60,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Center(
                                  child: Container(
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(circular),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: e['picUrl'],
                                    placeholder: (context, url) =>
                                        ProgressView(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              )),
                              Expanded(
                                child: Container(
//                                color: Colors.amberAccent,
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 8),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
                                      children: [
                                        Expanded(
                                          child: Container(
//                      color: Colors.green,
                                              child: Center(
                                            child: Align(
                                              alignment:
                                                  FractionalOffset.centerLeft,
                                              child: Text(
                                                e['name'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )),
                                        ),
                                        Expanded(
                                          child: Container(
//                                            color: Colors.green,
                                              child: Center(
                                            child: Align(
                                              alignment:
                                                  FractionalOffset.centerLeft,
                                              child: Text(
                                                getText(e),
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.grey[600]),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )),
                                        ),
                                      ]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Image.asset(
                                  'images/album/track_mv.png',
                                  width: 25,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Visibility(
            visible: !isNewSong,
            child: Container(
              height: 200,
              child: PageView(
                controller: PageController(
                    initialPage: 0, viewportFraction: (width - 30) / width),
                children: [
                  Container(
                    width: 100,
                    height: 200,
//                  color: color,
                    child: Column(
                      children: _newAlbum.sublist(0, 3).map((e) {
                        return Container(
                          height: 60,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Center(
                                  child: Container(
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(circular),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: e['blurPicUrl'],
                                    placeholder: (context, url) =>
                                        ProgressView(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              )),
                              Expanded(
                                child: Container(
//                                color: Colors.amberAccent,
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 8),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
                                      children: [
                                        Expanded(
                                          child: Container(
//                      color: Colors.green,
                                              child: Center(
                                            child: Align(
                                              alignment:
                                                  FractionalOffset.centerLeft,
                                              child: Text(
                                                e['name'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )),
                                        ),
                                        Expanded(
                                          child: Container(
//                                            color: Colors.green,
                                              child: Center(
                                            child: Align(
                                              alignment:
                                                  FractionalOffset.centerLeft,
                                              child: Text(
                                                e['artist']['name'],
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.grey[600]),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 200,
//                  color: color,
                    child: Column(
                      children: _newAlbum.sublist(3, 6).map((e) {
                        return Container(
                          height: 60,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Center(
                                  child: Container(
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(circular),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: e['blurPicUrl'],
                                    placeholder: (context, url) =>
                                        ProgressView(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              )),
                              Expanded(
                                child: Container(
//                                color: Colors.amberAccent,
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 8),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
                                      children: [
                                        Expanded(
                                          child: Container(
//                      color: Colors.green,
                                              child: Center(
                                            child: Align(
                                              alignment:
                                                  FractionalOffset.centerLeft,
                                              child: Text(
                                                e['name'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )),
                                        ),
                                        Expanded(
                                          child: Container(
//                                            color: Colors.green,
                                              child: Center(
                                            child: Align(
                                              alignment:
                                                  FractionalOffset.centerLeft,
                                              child: Text(
                                                e['artist']['name'],
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.grey[600]),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PagingScrollPhysics extends ScrollPhysics {
  final double itemDimension; // ListView children item 固定宽度
  final double leadingSpacing; // 选中 item 离左边缘留白
  final double maxSize; // 最大可滑动区域

  PagingScrollPhysics(
      {required this.maxSize,
      required this.leadingSpacing,
      required this.itemDimension,
      required ScrollPhysics parent})
      : super(parent: parent);

  @override
  PagingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PagingScrollPhysics(
        maxSize: maxSize,
        itemDimension: itemDimension,
        leadingSpacing: leadingSpacing,
        parent: buildParent(ancestor)!);
  }

  double _getPage(ScrollPosition position, double leading) {
    return (position.pixels + leading) / itemDimension;
  }

  double _getPixels(double page, double leading) {
    return (page * itemDimension) - leading;
  }

  Future<double> _getTargetPixels(
    ScrollPosition position,
    Tolerance tolerance,
    double velocity,
    double leading,
  ) async {
    double page = _getPage(position, leading);

    if (position.pixels < 0) {
      return 0;
    }

    if (position.pixels >= maxSize) {
      return maxSize;
    }

    if (position.pixels > 0) {
      if (velocity < -tolerance.velocity) {
        page -= 0.5;
      } else if (velocity > tolerance.velocity) {
        page += 0.5;
      }
      return _getPixels(page.roundToDouble(), leading);
    }
    return 0;
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.

    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent))
      return super.createBallisticSimulation(position, velocity);

    final Tolerance tolerance = this.tolerance;

    final double target =
        _getTargetPixels(position as ScrollPosition, tolerance, velocity, leadingSpacing) as double;
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

const List<int> TestDatas = const <int>[
  0,
  1,
];

class Menu {
  Menu({required this.title, required this.img, required this.path});

  String title;
  String img;
  String path;
}

List<Menu> videoCategoryList = <Menu>[
  Menu(
    title: R.string.dailySpecial,
    img: R.mipmap.dailySpecial,
    path: RouteName.PAGE_DAILY_RECOMMEND,
  ),
  Menu(
    title: R.string.fm,
    img: R.mipmap.fm,
    path: RouteName.PAGE_SONGS,
  ),
  Menu(
    title: R.string.playlist,
    img: R.mipmap.playlist, path: '',
  ),
  Menu(
    title: R.string.rankingList,
    img: R.mipmap.rankingList,
    path: RouteName.PAGE_RANKING_LIST,
  ),
  Menu(
    title: R.string.liveStreaming,
    img: R.mipmap.liveStreaming,
    path: '',
  ),
  Menu(
    title: R.string.digitalAlbum,
    img: R.mipmap.digitalAlbum,
    path: RouteName.PAGE_WEB,
    // path: RouteName.PAGE_DIGITAL_ALBUM,
  ),
  Menu(
    title: '唱聊',
    img: 'images/album/album_download.png',
    path: '',
  ),
  Menu(
    title: '游戏专区',
    img: 'images/find/t_dragonball_icn_radio.png',
    path: '',
  ),
];
