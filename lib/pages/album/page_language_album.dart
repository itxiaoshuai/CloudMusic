import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/model/digital_album_model.dart';
import 'package:cloud_music/pages/yuncun/page_video_list.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../../r.dart';

class LanguageAlbumPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LanguageAlbumPageState();
}

class _LanguageAlbumPageState extends State<LanguageAlbumPage> {
  @override
  Widget build(BuildContext context) {
    Widget tabBarContainer = TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      //创建TabBar实例
      isScrollable: true,
      //这个属性是导航栏是否支持滚动，false则会挤在一起了
      unselectedLabelColor: Colors.grey,
      //未选标签标签的颜色(这里定义为灰色)
      labelColor: Colors.red,
      //选中的颜色（黑色）
      indicatorColor: Colors.red,
      //指示器颜色
      indicatorWeight: 2.0,
      //指示器厚度
      tabs: choices.map((Choice choice) {
        //选项卡
        return Tab(
          text: choice.title,
        );
      }).toList(),
    );
    Widget tabContainer = DefaultTabController(
      length: choices.length,
      initialIndex: 0, //初始索引
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
//                color: Colors.teal.shade700,
                alignment: Alignment.center,
                child: tabBarContainer,
              ),
            ],
          ),
          Gaps.line,
          Expanded(
            child: TabBarView(
              children: choices.map((Choice choice) {
                return Center(
                  child: LanguageAlbumListPage(choice.area),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('语种风格馆'),
      ),
      body: tabContainer,
    );
  }
}

class LanguageAlbumListPage extends StatefulWidget {
  String area;

  LanguageAlbumListPage(this.area);

  @override
  State<StatefulWidget> createState() => _LanguageAlbumListPageState();
}

class _LanguageAlbumListPageState extends State<LanguageAlbumListPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<DigitalAlbumModel>(
        model: DigitalAlbumModel(),
        onModelReady: (model) {
          Map<String, dynamic> formData = {
            'area': widget.area,
          };
          model.loadData(formData);
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
          return ListView(
            children: [
              Container(
                // color: Colors.red,
//      padding: const EdgeInsets.all(18.0),
                child: LayoutBuilder(builder: (context, constraints) {
                  int count = 2;
                  double spacing = 15;
                  double totalWidthSpacing = spacing * (count + 1);
                  double width =
                      ((constraints.maxWidth - totalWidthSpacing) ~/ count)
                          .toDouble();
                  print(width);
                  return Padding(
                    padding: EdgeInsets.only(left: spacing),
                    child: Wrap(
                      spacing: spacing,
                      direction: Axis.horizontal,
                      children: model.albumList.map<Widget>((p) {
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(RouteName.PAGE_PAGE_ALBUM_DETAIL,arguments: p['albumId']);
                          },
                          child: Container(
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fitHeight,
                                          height: width-30,
                                          width: width-30,
                                          imageUrl: p['coverUrl'],
                                          placeholder: (context, url) =>
                                              ProgressView(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Image.asset(R.mipmap.album, height: width-30),
                                  ],
                                ),

                                Text(p['albumName']),
                                Text(p['artistName']),
                                Text(
                                  "¥${p['price']}",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              )
            ],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}


class Choice {
  const Choice({this.title, this.area});

  final String title;
  final String area;
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: '华语',
    area: 'Z_H',
  ),
  const Choice(
    title: '欧美',
    area: 'E_A',
  ),
  const Choice(
    title: '韩国',
    area: 'KR',
  ),
  const Choice(
    title: '日本',
    area: 'JP',
  ),
];
