import 'package:flutter/material.dart';
import 'package:cloud_music/data/protocol/user_detail_bean.dart';
import 'package:cloud_music/net/huyi_android_api.dart';
import 'package:cloud_music/widget/flexible_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'tab_music.dart';

///用户详情页
class UserDetailPage extends StatefulWidget {
  ///用户ID
  final int userId;

  const UserDetailPage({Key key, @required this.userId}) : super(key: key);

  State<StatefulWidget> createState() => UserDetailPageState();
}

class UserDetailPageState extends State<UserDetailPage> {
  UserDetail user;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user == null ? Container() : _DetailPage(user);
  }

  Future<void> initData() async {
    Map<String, dynamic> formData = {
      'uid': widget.userId,
    };
    var response = await http.get('/user/detail', queryParameters: formData);
    user = UserDetail.fromJsonMap(response.data);
    print(user.level);
    setState(() {});
  }
}

class _DetailPage extends StatelessWidget {
  final UserDetail user;

  const _DetailPage(this.user, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: _UserDetailAppBar(user))
            ];
          },
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: kToolbarHeight + kTextTabBarHeight),
              child: TabBarView(children: <Widget>[
                TabMusic(
                  userDetail: user,
                ),
                TabMusic(
                  userDetail: user,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserDetailAppBar extends StatelessWidget {
  final UserDetail user;

  const _UserDetailAppBar(this.user, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, width: 720, height: 1080, allowFontScaling: false);

    return SliverAppBar(
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () => Navigator.pop(context),
      ),
      //左侧按钮
      /**
       * 如果没有leading，automaticallyImplyLeading为true，就会默认返回箭头
       * 如果 没有leading 且为false，空间留给title
       * 如果有leading，这个参数就无效了
       */
      automaticallyImplyLeading: true,
      title: Text('大标题'),
      //标题
      centerTitle: false,
      //标题是否居中
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: null,
        )
      ],
      //右侧的内容和点击事件啥的
      elevation: 4,
      //阴影的高度
      forceElevated: false,
      //是否显示阴影
//      backgroundColor: Colors.green,
      //背景颜色
      brightness: Brightness.dark,
      //黑底白字，lignt 白底黑字

      //所有的icon的样式,不仅仅是左侧的，右侧的也会改变
      textTheme: TextTheme(),
      //字体样式
      primary: true,
      // appbar是否显示在屏幕的最上面，为false是显示在最上面，为true就显示在状态栏的下面
      titleSpacing: 16,
      //标题两边的空白区域
      expandedHeight: 330,
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
          child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(user.profile.backgroundUrl)),
        ),
        content: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          color: Colors.transparent,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Spacer(),
            InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 56,
                  height: 56,
                  child: Image.network(user.profile.avatarUrl),
                ),
              ),
            ),
            Row(
              children: <Widget>[],
            ),
            SizedBox(height: 10),
            Text(user.profile.nickname,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
            SizedBox(height: 6),
            Row(children: <Widget>[
              InkWell(child: Text('关注:${user.profile.follows}'), onTap: () {}),
              VerticalDivider(),
              InkWell(
                child: Text('粉丝:${user.profile.followeds}'),
                onTap: () {},
              ),
            ]),
            SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Text(
                    'Lv.${user.level}',
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
                SizedBox(width: 3),
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
            SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }
}

class PrimaryTabIndicator extends UnderlineTabIndicator {
  PrimaryTabIndicator({Color color: Colors.white})
      : super(
            insets: const EdgeInsets.only(bottom: 4),
            borderSide: BorderSide(color: color, width: 2.0));
}

///网易云音乐风格的TabBar
class RoundedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;

  const RoundedTabBar({Key key, @required this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: TabBar(
            indicator:
                PrimaryTabIndicator(color: Theme.of(context).accentColor),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).textTheme.bodyText1.color,
            tabs: tabs),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
