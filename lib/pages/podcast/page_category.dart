import 'package:cloud_music/data/protocol/RadioCategoryData.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/pages/podcast/widget_gridview_podcast.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:flutter/material.dart';

class PagePodcastCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PagePodcastCategoryStat();
}

class PagePodcastCategoryStat extends State<PagePodcastCategory>
    with AutomaticKeepAliveClientMixin<PagePodcastCategory> {
  List<Category> mData = [];

  @override
  bool get wantKeepAlive => true; //需要返回true
  @override
  void initState() {
    initData();
    super.initState();
  }

  Future initData() async {
    var response = await http.get('/dj/catelist');

    var data = RadioCategoryData.fromJson(response.data);

    if (response != null && mounted) {
      setState(() {
        mData = data.categories;
      });
    }
  }

  _buildMenu(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        // color: Colors.cyan,
        // 底色
        //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
        shape: BoxShape.rectangle,
        // 默认值也是矩形
        borderRadius: BorderRadius.circular((8.0)), // 圆角度
      ),
      child: GridView.count(
        shrinkWrap: true,
        //水平子Widget之间间距
        crossAxisSpacing: 10.0,
        //垂直子Widget之间间距
        //GridView内边距
        //一行的Widget数量
        crossAxisCount: 4,
        //子Widget列表
        children: mData.map((v) {
          return Center(
            child: Container(
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouteName.PAGE_RADIO_DETAIL);
                  },
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            v.picIPadUrl,
                            width: 30,
                          ),
                          Text(v.name),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Container(
      child: Column(
        children: mData.map((v) {
          return Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  // color: Colors.pink,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        v.name,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Center(
                          child: Material(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(
                                  30.0), //如果[borderRadius]被指定，那么[type]属性不能是 [MaterialType.circle]。
                            ),
                            child: InkWell(
                              onTap: () {
                                // Navigator.of(context)
                                //     .push(MaterialPageRoute(builder: (BuildContext context) {
                                //   return SongListPage();
                                // }));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      '更多',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.w100,
                                              fontSize: 14),
                                    ),
                                    Icon(Icons.chevron_right_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: PagePodcastCategoryModel(v.id),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildMenu(context),
          _buildBody(context),
        ],
      ),
    );
  }
}
