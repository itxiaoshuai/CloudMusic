import 'package:cloud_music/data/protocol/daily_recommend.dart';
import 'package:cloud_music/model/daily_recommend_model.dart';
import 'package:cloud_music/model/friend_fans_list_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/widget/flexible_app_bar.dart';
import 'package:common_utils/common_utils.dart';
import 'dart:ui';
import 'package:cloud_music/base/ConstImg.dart';

/// 每日推荐
class PageDailySpecial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageDailySpecialState();
}

class _PageDailySpecialState extends State<PageDailySpecial> {
  ScrollController _scrollController;
  bool isAppBarExpanded = true;
  double radian = 6.0;
  double pixel = 0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() => setState(() {
            if (_scrollController.hasClients &&
                _scrollController.offset > 0 &&
                _scrollController.offset < (200 - kToolbarHeight)) {
              radian =
                  6 - (_scrollController.offset / (200 - kToolbarHeight) * 6);
              pixel = (_scrollController.offset / (200 - kToolbarHeight) * 12);
              print('radian----${radian}');
            }

            isAppBarExpanded = _scrollController.hasClients &&
                _scrollController.offset <= (200 - kToolbarHeight);
          }));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ProviderWidget<DailyRecommendModel>(
            model: DailyRecommendModel(),
            onModelReady: (model) {
              // Map<String, dynamic> formData = {
              //   'uid': 1521312765,
              // };

              model.loadData();
            },
            builder: (context, model, child) {
              switch (model.layoutState) {
                case LayoutState.IDLE:
                  break;
                case LayoutState.LOADING:
                  return ViewStateLoadingWidget();
                  break;
                case LayoutState.EMPTY:
                  // TODO: Handle this case.
                  break;
                case LayoutState.ERROR:
                  // TODO: Handle this case.
                  break;
                case LayoutState.UNAUTHORIZED:
                  // TODO: Handle this case.
                  break;
                case LayoutState.SUCCESS:
                  // TODO: Handle this case.
                  break;
              }
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    title: Offstage(
                      child: Text('每日推荐'),
                      offstage: isAppBarExpanded,
                    ),
                    pinned: true,
                    expandedHeight: 250.0,
                    flexibleSpace: FlexibleDetailBar(
                      background: PlayListHeaderBackground(
                        pixel: pixel,
                        imageUrl:
                            'https://p1.music.126.net/owwmF9E88Rc_Gjf-XSUU5Q==/109951164132178640.jpg',
                      ),
                      content: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        color: Colors.transparent,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Spacer(),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '${DateUtil.formatDate(DateTime.now(), format: 'd')}',
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '/${DateUtil.formatDate(DateTime.now(), format: 'M')}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Material(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Row(children: <Widget>[
                                            Text(
                                              '历史日推',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Image.asset(
                                              'images/lp_vip.png',
                                              width: 20,
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(height: 40),
                            ]),
                      ),
                    ),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline), onPressed: () {})
                    ],
                    bottom: MusicListHeader(
                      30,
                      radian: radian,
                      tail: Container(
                        margin: EdgeInsets.only(right: 15),
                        child: IconButton(
                          icon: Image.asset(
                            ConstImgResource.multipleSelection,
                            width: 20,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      //返回组件集合
                      List.generate(model.data.data.dailySongs.length,
                          (int index) {
                        DailySongs song = model.data.data.dailySongs[index];
                        //返回 组件
                        return Container(
                          color: Colors.white,
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                print(
                                    '###########################点击了##################################');
                              },
                              child: Container(
                                height: 60,
                                //不要在这里设置背景色，否则会遮挡水波纹效果,如果设置的话尽量设置Material下面的color来实现背景色
                                margin: EdgeInsets.all(0.0),
                                child: TrackItem(song),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
              ;
            }));
  }
}

///播放列表头部背景
class PlayListHeaderBackground extends StatelessWidget {
  final String imageUrl;
  double pixel;

  PlayListHeaderBackground({@required this.imageUrl, Key key, this.pixel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('pixel----->${pixel}');
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: pixel, sigmaY: pixel),
          child: Container(color: Colors.black.withOpacity(0)),
        )
      ],
    );
  }
}

//曲线路径
class BottomClipper extends CustomClipper<Path> {
  double radian; //弧度

  BottomClipper({
    this.radian = 5,
  });

  @override
  Path getClip(Size size) {
    print('radian----->${radian}');
    var paint = Paint();

    paint.color = Colors.lightBlue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    var startPoint = Offset(0, 0);
    var controlPoint1 = Offset(size.width / 4, radian);
    var controlPoint2 = Offset(3 * size.width / 4, radian);
    var endPoint = Offset(size.width, 0);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    // path.lineTo(0, 50); //第1个点
    // path.lineTo(0, size.height); //第2个点

    path.lineTo(size.width, size.height); //第3个点
    path.lineTo(0, size.height); //第4个点
    path.lineTo(0, 0); //第4个点

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TrackItem extends StatelessWidget {
  TrackItem(this.song);

  final DailySongs song;

  String getText() {
    StringBuffer stringBuffer = new StringBuffer();
    var length = song.artists.length;
    song.artists.forEach((item) {
      if (length == 1) {
        stringBuffer.write(item.name);
      }
      if (length > 1) {
        stringBuffer.write(item.name);
        stringBuffer.write('/');
      }

      length--;
    });
    if (song.album != null) {
      if (song.album.name != null) stringBuffer.write('-');
      stringBuffer.write(song.album.name);
    }

    return stringBuffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: song.album.picUrl,
                placeholder: (context, url) => ProgressView(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Container(
//              color: Colors.amberAccent,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
                  children: [
                    Expanded(
                      child: Container(
//                      color: Colors.green,
                          child: Center(
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            song.name,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                    ),
                    Expanded(
                      child: Container(
//                      color: Colors.green,
                          child: Center(
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            getText(),
                            style:
                                TextStyle(fontSize: 8, color: Colors.grey[600]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                    ),
                  ]),
            ),
          ),
          Container(
//            color: Colors.blue,
            child: Visibility(
              child: IconButton(
                  iconSize: 25,
                  icon: ImageIcon(AssetImage("images/album/track_mv.png")),
                  color: Colors.grey[500],
                  onPressed: () {}),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: song.mvid > 0,
            ),
          ),
          Container(
//            color: Colors.red,
            child: IconButton(
                iconSize: 15,
                icon: ImageIcon(AssetImage("images/album/track_more.png")),
                color: Colors.grey[500],
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 406.0,
                      );
                    },
                  ).then((val) {
                    print(val);
                  });
                }),
          ),
        ],
      ),
    );
  }
}

class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  MusicListHeader(this.count, {this.tail, this.radian});

  int count;

  Widget tail;
  double radian; //弧度

  @override
  Widget build(BuildContext context) {
    print('radian----MusicListHeader${radian}');
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      child: Container(
        color: Colors.transparent,
        child: SizedBox.fromSize(
          size: preferredSize,
          child: ClipPath(
            //路径裁切组件
            clipper: BottomClipper(radian: radian), //路径
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 16)),
                  IconButton(
                    icon: Image.asset(
                      'images/play.png',
                      width: 25,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                  // Image.asset(
                  //   'images/play.png',
                  //   color: Colors.red,
                  //   width: 25,
                  // ),
                  Padding(padding: EdgeInsets.only(left: 4)),
                  Text(
                    "播放全部",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Padding(padding: EdgeInsets.only(left: 2)),
                  Spacer(),
                  tail,
                ]..removeWhere((v) => v == null),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
