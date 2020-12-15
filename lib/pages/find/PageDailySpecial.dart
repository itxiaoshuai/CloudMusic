import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_app/base/CommonLoading.dart';
import 'package:flutter_app/widget/flexible_app_bar.dart';
import 'package:common_utils/common_utils.dart';

/// 每日推荐
class PageDailySpecial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageDailySpecialState();
}

class _PageDailySpecialState extends State<PageDailySpecial> {
  ScrollController _scrollController;
  bool isAppBarExpanded = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() => setState(() {
            print(
                'Scroll view Listener is called offset ${_scrollController.offset}');
          }));

  }
  bool get _changecolor {
    return _scrollController.hasClients
        && _scrollController.offset > (200-kToolbarHeight);
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          title: Offstage(
            child: Text('每日推荐'),offstage: _changecolor ,
          ),

          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleDetailBar(
            background: FlexShadowBackground(
              child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://p4.music.126.net/2R-ib822lFEPSyTh2mDTxw==/109951165358901806.jpg')),
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
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Row(children: <Widget>[
                                  Text(
                                    '历史日推',
                                    style: TextStyle(color: Colors.black),
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
            IconButton(icon: Icon(Icons.help_outline), onPressed: () {})
          ],
          bottom: MusicListHeader(30),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            //返回组件集合
            List.generate(20, (int index) {
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
                      child: TrackItem(),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class TrackItem extends StatelessWidget {
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
                imageUrl:
                    'https://p1.music.126.net/Jh1iS5wFR5Xz_GNML996VA==/109951165046243126.jpg',
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
                            '会不会（吉他版）',
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
                            '刘大壮-会不会',
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
            child: IconButton(
                iconSize: 25,
                icon: ImageIcon(AssetImage("images/album/track_mv.png")),
                color: Colors.grey[500],
                onPressed: () {}),
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
  MusicListHeader(this.count, {this.tail});

  final int count;

  final Widget tail;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        child: InkWell(
          onTap: () {},
          child: SizedBox.fromSize(
            size: preferredSize,
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 16)),
                Image.asset(
                  'images/play.png',
                  color: Colors.red,
                  width: 25,
                ),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _DailyMusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('每日推荐'),
          titleSpacing: 0,
          forceElevated: false,
          elevation: 0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.help_outline), onPressed: () {})
          ],
          expandedHeight: 232 - MediaQuery.of(context).padding.top,
          pinned: true,
        ),
      ],
    );
  }
}
