import 'package:cloud_music/widget/CustomUnderlineTabIndicator.dart';
import 'package:flutter/material.dart';

class MyScrv extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new MyScrvState();
  }
}

class MyScrvState extends State<MyScrv> with SingleTickerProviderStateMixin {
  List<String> _list = new List();
  List<Color> myColors = new List();

  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
    _list.add("政府");
    _list.add("部门11");
    _list.add("部门22");
    myColors.add(Colors.red);
    myColors.add(Colors.lightBlue);
    myColors.add(Colors.lightBlue);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CustomScrollView(physics: ScrollPhysics(), slivers: <Widget>[
      const SliverAppBar(
        pinned: true,
        expandedHeight: 250.0,
        flexibleSpace: const FlexibleSpaceBar(
          title: const Text('demo'),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: StickyTabBarDelegate(
          child: TabBar(
            indicator: CustomUnderlineTabIndicator(
                insets:
                EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
                borderSide: BorderSide(
                  width: 5,
                  color: Color(0xff00cdd7),
                )),
            labelColor: Colors.black,
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(text: '主页'),
              Tab(text: '动态'),
            ],
          ),
        ),
      ),

      new SliverFixedExtentList(
        itemExtent: 50.0,
        delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return new Container(
              alignment: Alignment.center,
              color: Colors.lightBlue[100 * (index % 9)],
              child: new Text('list item $index'),
            );
          },
        ),
      ),
    ]);
  }


}
class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

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