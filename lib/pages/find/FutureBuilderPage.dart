import 'package:flutter/material.dart';
import 'package:cloud_music/pages/playllist/page_playlist_detail.dart';
import 'package:cloud_music/widget/flexible_app_bar.dart';

class NestedScrollDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NestedScrollState();
}

class NestedScrollState extends State<NestedScrollDemoPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  var imgs = [
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-02.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-03.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-04.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-05.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-06.png"
  ];

  void changeImg(int pos) {
    setState(() {
      imgs[pos] = "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-08.png";
    });
  }

  void onPageChanged(int pos) {
    print("当前是第$pos页");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: true,
              flexibleSpace: Container(
                margin: EdgeInsets.only(top: 50),
                color: Colors.blue,
                child: Column(
                  children: [
//                    SizedBox(
//                      height: kToolbarHeight + kTextTabBarHeight,
//                    ),
                    InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 56,
                          height: 56,
                          child: Image.network(
                              'https://p4.music.126.net/S8_sVVdNkr84Jcb-CFcjYQ==/109951165150069282.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: PageView(
          children: <Widget>[
            Image.network(imgs[0]),
            Image.network(imgs[1]),
            Image.network(imgs[2]),
            Image.network(imgs[3]),
            GestureDetector(
                onTap: () => changeImg(4), child: Image.network(imgs[4]))
          ],
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

///伸缩自如的AppBar
class _UserDetailAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: Container(),
      expandedHeight: 230.0,
      flexibleSpace: Column(
        children: [
          Column(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 56,
                    height: 56,
                    child: Image.network(
                        'https://p4.music.126.net/S8_sVVdNkr84Jcb-CFcjYQ==/109951165150069282.jpg'),
                  ),
                ),
              ),
              Text('情深深你大爷'),
              Row(
                children: [
                  Text('关注4'),
                  Text('粉丝0'),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    child: Text(
                      "Lv.5",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[400], // 底色
                      shape: BoxShape.rectangle, // 默认值也是矩形
                      borderRadius: BorderRadius.circular((20.0)), // 圆角度
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    child: Text(
                      "+关注",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.rectangle, // 默认值也是矩形
                      borderRadius: BorderRadius.circular((20.0)), // 圆角度
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    child: Text(
                      "发私信",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.rectangle, // 默认值也是矩形
                      borderRadius: BorderRadius.circular((20.0)), // 圆角度
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 播放列表头部
class _PlaylistDetailHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlexibleDetailBar(
     background: PlayListHeaderBackground(imageUrl: 'https://p1.music.126.net/owwmF9E88Rc_Gjf-XSUU5Q==/109951164132178640.jpg'),
      content: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Text(''),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 0, bottom: 4, right: 15),
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 56,
                  height: 56,
                  child: Image.network(
                      'https://p4.music.126.net/S8_sVVdNkr84Jcb-CFcjYQ==/109951165150069282.jpg'),
                ),
              ),
            ),
            Text('情深深你大爷'),
            Row(
              children: [
                Text('关注4'),
                Text('粉丝0'),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Text(
                    "Lv.5",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[400], // 底色
                    shape: BoxShape.rectangle, // 默认值也是矩形
                    borderRadius: BorderRadius.circular((20.0)), // 圆角度
                  ),
                ),
                Spacer(),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Text(
                    "+关注",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.rectangle, // 默认值也是矩形
                    borderRadius: BorderRadius.circular((20.0)), // 圆角度
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Text(
                    "发私信",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.rectangle, // 默认值也是矩形
                    borderRadius: BorderRadius.circular((20.0)), // 圆角度
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
