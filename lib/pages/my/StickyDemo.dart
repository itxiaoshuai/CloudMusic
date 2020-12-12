import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/CommonLoading.dart';

class StickyDemo extends StatefulWidget {
  @override
  _StickyDemoState createState() => _StickyDemoState();
}

class _StickyDemoState extends State<StickyDemo>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver-sticky效果'),
              background: Image.network(
                'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: '创建歌单'),
                  Tab(text: '收藏歌单'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: ListView(
              children: [
                Container(
                  child: Center(
                      child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: "https://picsum.photos/id/0/800/800",
                        placeholder: (context, url) => ProgressView(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )),
                ),
                Container(
                  child: Center(
                      child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: "https://picsum.photos/id/0/800/800",
                        placeholder: (context, url) => ProgressView(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )),
                ),
                Container(
                  child: Center(
                      child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: "https://picsum.photos/id/0/800/800",
                        placeholder: (context, url) => ProgressView(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )),
                )
              ],
            ),
          ),
        ],
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
