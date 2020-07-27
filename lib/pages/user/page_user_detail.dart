import 'package:flutter/material.dart';
import 'package:flutter_app/data/protocol/user_detail_bean.dart';
import 'package:flutter_app/widget/flexible_app_bar.dart';

///用户详情页
class UserDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DetailPage();
  }
}

class _DetailPage extends StatelessWidget {
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
                  sliver: _UserDetailAppBar())
            ];
          },
          body: Text(''),
        ),
      ),
    );
  }
}

class _UserDetailAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: Container(),
      flexibleSpace: FlexibleDetailBar(
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      child: Text('xxx'),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text('user.profile.nickname',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                Row(children: <Widget>[
                  InkWell(child: Text('关注:${4}'), onTap: () {}),
                  VerticalDivider(),
                  InkWell(
                    child: Text('粉丝:${5}'),
                    onTap: () {},
                  ),
                ]),
                SizedBox(height: 6),
                VerticalDivider(),
              ]),
        ),
      ),
      expandedHeight: 330,
      elevation: 0,
      forceElevated: false,
      bottom: RoundedTabBar(
        tabs: <Widget>[
          Tab(text: '音乐'),
          Tab(text: '动态'),
        ],
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

class TabMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('xxx'),
    );
  }
}
