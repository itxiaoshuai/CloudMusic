import 'package:cloud_music/pages/podcast/page_category.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/widget/CustomUnderlineTabIndicator.dart';
import 'package:cloud_music/widget/HomeDrawer.dart';
class PagePodcast extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PagePodcastState();
}

class PagePodcastState extends State<PagePodcast> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 1)
      ..addListener(() {
        print('_tabControllerIndex' + _tabController.index.toString());
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('images/icon_bg_my.png'),
        //       fit: BoxFit.cover,
        //     )),

        child: Scaffold(
            drawer: HomeDrawer(),
            backgroundColor:
            _tabController.index == 0 ? Colors.transparent : Colors.white,
            //把scaffold的背景色改成透明
            appBar: AppBar(
              brightness: Brightness.light,
              leading: IconButton(
                  icon: Icon(Icons.dehaze,color: Colors.black,),
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                  }
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: null,
                )
              ],
              centerTitle: true,
              // backgroundColor:
              // _tabController.index == 0 ? Colors.transparent : Colors.red,
              elevation: 0,
              //appbar的阴影
              title: TabBar(
                labelPadding: EdgeInsets.only(left: 0, right: 0),
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: false,
                labelStyle:
                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                indicator: CustomUnderlineTabIndicator(
                    insets: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
                    borderSide: BorderSide(
                      width: 5,
                      color: Color(0xff00cdd7),
                    )),
                labelColor: Colors.black,
                // labelStyle: TextStyle(),
                unselectedLabelColor: Colors.grey[600],
                // unselectedLabelStyle: TextStyle(),
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    text: '听听',
                  ),
                  Tab(
                    text: '推荐',
                  ),
                  Tab(
                    text: '分类',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Center(child: Text('听听')),
                Center(child: Text('推荐')),
                // Center(child: Text('分类')),
                PagePodcastCategory(),
              ],
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
