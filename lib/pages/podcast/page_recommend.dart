import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/data/protocol/RadioCategoryData.dart';
import 'package:cloud_music/net/http.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/model/podcast_recommend_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';

import '../../r.dart';

class PagePodcastRecommend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PagePodcastRecommendState();
}

class PagePodcastRecommendState extends State<PagePodcastRecommend>
    with AutomaticKeepAliveClientMixin<PagePodcastRecommend> {
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

  _buildRank(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;
    return Container(
      height: 240,
      child: PageView(
        // controller: PageController(
        //     initialPage: 0, viewportFraction: (width - 30) / width),
          children: [
            PagePodcastRecommendRank(),
            PagePodcastRecommendRank(),
            PagePodcastRecommendRank(),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildRank(context),
        ],
      ),
    );
  }
}

class PagePodcastRecommendRank extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PagePodcastRecommendRankState();
}

class PagePodcastRecommendRankState extends State with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    var i = 0;
    return Material(
        child: ProviderWidget<PodcastRecommendModel>(
            model: PodcastRecommendModel(),
            onModelReady: (model) {
              model.loadData();
            },
            builder: (context, model, child) {
              switch (model.layoutState) {
                case LayoutState.IDLE:
                  break;
                case LayoutState.LOADING:
                  return ViewStateLoadingWidget();
                  break;
                case LayoutState.EMPTY:
                // TODO: Handle this case.
                  break;
                case LayoutState.ERROR:
                // TODO: Handle this case.
                  break;
                case LayoutState.UNAUTHORIZED:
                // TODO: Handle this case.
                  break;
                case LayoutState.SUCCESS:
                // TODO: Handle this case.
                  break;
              }
              return Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // 底色
                  //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                  shape: BoxShape.rectangle,
                  // 默认值也是矩形
                  borderRadius: BorderRadius.circular((8.0)), // 圆角度
                ),
                child: Column(children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '声音榜',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: model.data.map<Widget>((p) {
                          i++;
                          return Container(
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Center(
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.fill,
                                          imageUrl: p['avatarUrl'],
                                          placeholder: (context, url) =>
                                              ProgressView(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    )),
                                Gaps.hGap15,
                                Text('${i}',style: R.style.textBoldDark14,),
                                Gaps.hGap15,
                                Text("${p['nickName']}"),
                              ],
                            ),
                          );
                        }).toList(),
                      )),
                ]),
              );
            }));
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        // 底色
        //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
        shape: BoxShape.rectangle,
        // 默认值也是矩形
        borderRadius: BorderRadius.circular((8.0)), // 圆角度
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
