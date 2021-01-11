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
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

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

  LanguageAlbumListPage(this. area);

  @override
  State<StatefulWidget> createState() => _LanguageAlbumListPageState();
}

class _LanguageAlbumListPageState extends State<LanguageAlbumListPage>   with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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
                        return Container(
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fitHeight,
                                    height: width,
                                    width: width,
                                    imageUrl: p['coverUrl'],
                                    placeholder: (context, url) =>
                                        ProgressView(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),

                              Text(p['albumName']),
                              Text(p['artistName']),
                              Text(
                                "¥${p['price']}",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
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

class VideoItem extends StatelessWidget {
  final double width; //宽
  final double height; //高
  final double circular; //圆角
  final String img; //图片
  final String updateFrequency; //每周几更新
  final String describe; //描述
  final int playCount;
  final int id;
  final String avatarUrl;
  final int durationms;

  VideoItem({
    this.width,
    this.height,
    this.circular = 6.0,
    this.updateFrequency = "",
    this.img,
    this.describe = '',
    this.playCount = 0,
    this.id,
    this.avatarUrl,
    this.durationms,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          width: width,
          child: Container(
            // color: Colors.blue,
            margin: EdgeInsets.only(bottom: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 100,
                color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          height: 200,
                          imageUrl: img,
                          placeholder: (context, url) => ProgressView(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        Positioned(
                            left: 10,
                            top: 160,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                shape: BoxShape.rectangle,
                                // 默认值也是矩形
                                borderRadius:
                                    BorderRadius.circular((30.0)), // 圆角度
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  avatarUrl == null ? "" : avatarUrl,
                                ),
                                backgroundColor: Colors.black,
                                radius: 15.0,
                              ),
                            )),
                        Positioned(
                            bottom: 10,
                            right: 5,
                            child: Text(
                              DateUtil.formatDateMs(durationms,
                                  format: "mm:ss"),
                              style: TextStyles.textGray12,
                            )),
                      ],
                    ),
                    Text(
                      describe,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
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
