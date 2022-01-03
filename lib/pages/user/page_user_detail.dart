import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/pages/user/tan_dynamic.dart';
import 'package:cloud_music/widget/CustomUnderlineTabIndicator.dart';
import 'package:cloud_music/widget/flexible_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/data/protocol/user_detail_bean.dart';
import 'package:cloud_music/net/http.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../r.dart';
import 'tab_music.dart';

///用户详情页
class UserDetailPage extends StatefulWidget {
  ///用户ID
  final int? userId;

  const UserDetailPage({required Key key, required this.userId})
      : super(key: key);

  State<StatefulWidget> createState() => UserDetailPageState();
}

class UserDetailPageState extends State<UserDetailPage> {
  UserDetail? user;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container();
    } else {
      return DetailPageWidget(user!);
    }
  }

  Future<void> initData() async {
    Map<String, dynamic> formData = {
      'uid': widget.userId,
    };
    var response = await http.get('/user/detail', queryParameters: formData);
    user = UserDetail.fromJsonMap(response.data);
    print(user?.level);
    setState(() {});
  }
}

class DetailPageWidget extends StatefulWidget {
  final UserDetail user;

  const DetailPageWidget(this.user) : super();

  @override
  _DetailPageWidgetState createState() => _DetailPageWidgetState();
}

class _DetailPageWidgetState extends State<DetailPageWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isAppBarExpanded = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController()
      ..addListener(() => setState(() {
            // if (_scrollController.hasClients &&
            //     _scrollController.offset > 0 &&
            //     _scrollController.offset < (200 - kToolbarHeight)) {
            //   radian =
            //       6 - (_scrollController.offset / (200 - kToolbarHeight) * 6);
            //   pixel = (_scrollController.offset / (200 - kToolbarHeight) * 12);
            //   print('radian----${radian}');
            // }
            // print(_scrollController.offset);
            isAppBarExpanded = _scrollController.hasClients &&
                _scrollController.offset <=
                    (450 -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top -
                        50);
          }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: _UserDetailAppBar(widget.user, isAppBarExpanded))
            ];
          },
          body: SafeArea(
            child: Container(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: kToolbarHeight + kTextTabBarHeight),
                child: TabBarView(children: <Widget>[
                  TabMusic(
                    userDetail: widget.user,
                  ),
                  TabDynamic(
                    userDetail: widget.user,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserDetailAppBar extends StatelessWidget {
  const _UserDetailAppBar(this.user, this.isAppBarExpanded, {Key? key})
      : super(key: key);
  final UserDetail user;
  final bool isAppBarExpanded;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Container(
          child: Offstage(
            child: Container(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.profile.nickname,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Text(
                                  '${user.profile.followeds} 粉丝',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ))),
                    Container(
                      width: 160.w,
                      height: 60.w,
                      child: Center(
                        child: Text(
                          "+关注",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle, // 默认值也是矩形
                        borderRadius: BorderRadius.circular((20.0)), // 圆角度
                      ),
                    ),
                  ],
                )),
            offstage: isAppBarExpanded,
          )),

      actions: <Widget>[
        Builder(
          builder: (context) {
            return PopupMenuButton<String>(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                  ),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                          value: 'id01',
                          child: Row(
                            children: [
                              Image.asset(
                                R.mipmap.share,
                                width: 15,
                                color: Colors.black,
                              ),
                              Gaps.hGap5,
                              Text('分享'),
                            ],
                          )),
                      PopupMenuItem<String>(
                          value: 'id02', child: Text('加入黑名单')),
                      PopupMenuItem<String>(value: 'id03', child: Text('举报')),
                    ],
                onSelected: (String value) {});
          },
        ),
      ],
      //右侧的内容和点击事件啥的
      elevation: 0,
      //阴影的高度
      forceElevated: false,
      //是否显示阴影
      backgroundColor: Colors.transparent,
      //背景颜色
      brightness: Brightness.dark,
      //黑底白字，lignt 白底黑字

      //所有的icon的样式,不仅仅是左侧的，右侧的也会改变
      textTheme: TextTheme(),
      //字体样式
      primary: true,
      // appbar是否显示在屏幕的最上面，为false是显示在最上面，为true就显示在状态栏的下面
      titleSpacing: 0,
      //标题两边的空白区域
      expandedHeight: 450,
      //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
      floating: false,
      //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
      pinned: true,
      //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
      snap: false,
      bottom: RoundedTabBar(
        tabs: <Widget>[
          Tab(text: '音乐'),
          Tab(text: '动态'),
        ],
      ),
      //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
      flexibleSpace: FlexibleDetailBar(
          background: FlexShadowBackground(
            key: ValueKey(FlexibleDetailBar),
            child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(user.profile.backgroundUrl)),
          ),
          content: Stack(
            children: [
              Container(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent,
                        child: ClipPath(
                          //路径裁切组件
                          clipper: BottomClipper(radian: 20), //路径
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              user.profile.backgroundUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Container(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 50,
                      child: Center(
                        child: Container(
                          height: 180,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // 底色
                              //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                              shape: BoxShape.rectangle,
                              // 默认值也是矩形
                              borderRadius: BorderRadius.circular((8.0)), // 圆角度
                            ),
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.profile.nickname,
                                    style: R.style.textBoldDark18,
                                  ),
                                  Container(
                                    // color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${user.profile.follows} 关注',
                                          style: R.style.textDark14,
                                        ),
                                        Gaps.hGap8,
                                        Container(
                                          width: 0.5,
                                          height: 10,
                                          color: Colors.grey[500],
                                        ),
                                        Gaps.hGap8,
                                        Text(
                                          '${user.profile.followeds} 粉丝',
                                          style: R.style.textDark14,
                                        ),
                                        Gaps.hGap8,
                                        Container(
                                          width: 0.5,
                                          height: 10,
                                          color: Colors.grey[500],
                                        ),
                                        Gaps.hGap8,
                                        Text(
                                          'Lv.${user.level}',
                                          style: R.style.textDark14,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gaps.vGap5,
                                  Text(
                                    '${user.profile.signature}',
                                    style: R.style.textGray14,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Gaps.vGap15,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 160.w,
                                        height: 60.w,
                                        child: Center(
                                          child: Text(
                                            "+关注",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.rectangle, // 默认值也是矩形
                                          borderRadius: BorderRadius.circular(
                                              (20.0)), // 圆角度
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: 160.w,
                                        height: 60.w,
                                        padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5),
                                        child: Center(
                                          child: Text(
                                            "私信",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 0.5),
                                          color: Colors.transparent,
                                          shape: BoxShape.rectangle, // 默认值也是矩形
                                          borderRadius: BorderRadius.circular(
                                              (20.0)), // 圆角度
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 200,
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(60),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(user.profile.avatarUrl),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
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

class PrimaryTabIndicator extends UnderlineTabIndicator {
  PrimaryTabIndicator({Color color: Colors.white})
      : super(
            insets: const EdgeInsets.only(bottom: 4),
            borderSide: BorderSide(color: color, width: 2.0));
}

//曲线路径
class BottomClipper extends CustomClipper<Path> {
  double radian; //弧度

  BottomClipper({
    this.radian = 5,
  });

  @override
  Path getClip(Size size) {
    var paint = Paint();

    paint.color = Colors.lightBlue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    var controlPoint1 = Offset(3 * size.width / 4, size.height);
    var controlPoint2 = Offset(size.width / 4, size.height);
    var endPoint = Offset(0, size.height - radian);

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - radian); //第3个点
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.lineTo(0, 0); //第4个点

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

///网易云音乐风格的TabBar
class RoundedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;

  const RoundedTabBar({required this.tabs}) : super();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      child: Material(
        color: Colors.grey[100],
        child: TabBar(
            indicator: CustomUnderlineTabIndicator(
                insets: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
                borderSide: BorderSide(
                  width: 5,
                  color: Color(0xff00cdd7),
                )),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).textTheme.bodyText1!.color,
            tabs: tabs),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
