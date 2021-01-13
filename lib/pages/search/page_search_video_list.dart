import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/model/search_model.dart';
import 'package:cloud_music/pages/my/PageMy.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/widget/head_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../../r.dart';

class SearchVideoListPage extends StatefulWidget {
  SearchVideoListPageState createState() => SearchVideoListPageState();
}

class SearchVideoListPageState extends State<SearchVideoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<SearchModel>(
          model: SearchModel(),
          onModelReady: (model) {
            Map<String, dynamic> formData = {'keywords': "四季予你", "type": 1014};
            model.loadSearchResult(formData);
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
            // return Text(model.data['result']['playlists'].toString());
            return ListView(
              children: [
                Container(
                  child: LayoutBuilder(builder: (context, constraints) {
                    int count = 2;
                    double spacing = 15;
                    double totalWidthSpacing = spacing * (count + 1);
                    double width =
                        ((constraints.maxWidth - totalWidthSpacing) ~/ count)
                            .toDouble();
                    return Padding(
                      padding: EdgeInsets.only(left: spacing),
                      child: Wrap(
                        spacing: spacing,
                        direction: Axis.horizontal,
                        children:
                            model.data['result']['videos'].map<Widget>((p) {
                          return VideoItem(
                            id: p['creator'].length > 0
                                ? p['creator'][0]['userId']
                                : 0,
                            width: width,
                            playCount: p['playTime'],
                            img: p['coverUrl'],
                            describe: p['title'],
                            durationms: p['durationms'],
                            // avatarUrl: p['coverUrl']
                          );
                        }).toList(),
                      ),
                    );
                  }),
                )
              ],
            );
          }),
    );
  }
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
          // color: Colors.blue,
          margin: EdgeInsets.only(bottom: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 200,
                        width: width,
                        imageUrl: img,
                        placeholder: (context, url) => ProgressView(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Positioned(
                          left: 10,
                          bottom: 10,
                          child: id > 0 ? HeadPortraitWidget(id) : Container()),
                      Positioned(
                          bottom: 10,
                          right: 5,
                          child: Text(
                            DateUtil.formatDateMs(durationms, format: "mm:ss"),
                            style: TextStyles.textGray12,
                          )),
                    ],
                  ),
                  Container(
                    height: 50,
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: Text(
                      describe,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: R.style.textDark12,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          R.mipmap.triangle,
                          color: Colors.grey,
                          height: 12,
                        ),
                        Text(
                          NumberUtils.amountConversion(playCount),
                          style: R.style.textGray10,
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap5,
                ],
              ),
            ),
          ),
        ));
  }
}
