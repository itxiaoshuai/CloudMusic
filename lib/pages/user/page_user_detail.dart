import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/pages/user/tan_dynamic.dart';
import 'package:cloud_music/widget/CustomUnderlineTabIndicator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/data/protocol/user_detail_bean.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/widget/flexible_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../r.dart';
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
            child: Container(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: kToolbarHeight + kTextTabBarHeight),
                child: TabBarView(children: <Widget>[
                  TabMusic(
                    userDetail: user,
                  ),
                  TabDynamic(
                    userDetail: user,
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
  final UserDetail user;

  const _UserDetailAppBar(this.user, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onPressed: (){

          },
        )
      ],
      //右侧的内容和点击事件啥的
      elevation: 4,
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
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Container(
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                borderRadius:
                                    BorderRadius.circular((20.0)), // 圆角度
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 160.w,
                              height: 60.w,
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5),
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
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                color: Colors.transparent,
                                shape: BoxShape.rectangle, // 默认值也是矩形
                                borderRadius:
                                    BorderRadius.circular((20.0)), // 圆角度
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
            labelColor: Theme.of(context).textTheme.bodyText1.color,
            tabs: tabs),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
