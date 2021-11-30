import 'package:cloud_music/model/user_info_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:flutter/material.dart';

class HeadPortraitWidget extends StatefulWidget {
  HeadPortraitWidget(this.id);

  final int id;

  @override
  _HeadPortraitWidgetState createState() => _HeadPortraitWidgetState();
}

class _HeadPortraitWidgetState extends State<HeadPortraitWidget> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<UserInfoModel>(
        model: UserInfoModel(),
        child: Container(),
        onModelReady: (model) {
          model.loadData(widget.id);
        },
        builder: (context, model, child) {
          switch (model.layoutState) {
            case LayoutState.IDLE:
              break;
            case LayoutState.LOADING:
              // return ViewStateLoadingWidget();
              return Container();
              break;
            case LayoutState.EMPTY:
              // TODO: Handle this case.
              break;
            case LayoutState.ERROR:
             return Container();
              break;
            case LayoutState.UNAUTHORIZED:
              // TODO: Handle this case.
              break;
            case LayoutState.SUCCESS:
              // TODO: Handle this case.
              break;
          }
          // return Text(model.data['result']['playlists'].toString());
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.rectangle,
              // 默认值也是矩形
              borderRadius: BorderRadius.circular((30.0)), // 圆角度
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                model.data.profile.avatarUrl,
              ),
              backgroundColor: Colors.black,
              radius: 15.0,
            ),
          );
        });
  }
}
