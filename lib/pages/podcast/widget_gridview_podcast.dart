import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/data/protocol/radio_hot.dart';
import 'package:cloud_music/model/daily_recommend_model.dart';
import 'package:cloud_music/model/podcast_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/widget/ListItemCustom.dart';
import 'package:cloud_music/widget/base_song_img_item.dart';
import 'package:flutter/material.dart';

class PagePodcastCategoryModel extends StatefulWidget {
  PagePodcastCategoryModel(this.id,)
      : assert(id != null, 'playlist id，can not be null');
  final int id;

  @override
  State<StatefulWidget> createState() => PagePodcastCategoryModelStat();
}

class PagePodcastCategoryModelStat extends State<PagePodcastCategoryModel>  {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: ProviderWidget<PodcastModel>(
            model: PodcastModel(),
            onModelReady: (model) {
              // Map<String, dynamic> formData = {
              //   'uid': 1521312765,
              // };

              model.loadData(widget.id);
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
                child: LayoutBuilder(builder: (context, constraints) {
                  int count = 3;
                  double spacing = 8;
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
                      children: model.data.map<Widget>((p) {
                        return BaseImgItem(
                          id: p.id,
                          width: width,
                          img: p.picUrl,
                          describe: p.name,
                          playCount: p.subCount,
                        );
                      }).toList(),
                    ),
                  );
                }),
              );
            }));
  }
}
