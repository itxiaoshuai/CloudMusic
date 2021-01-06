import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/model/friend_fans_list_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_music/data/protocol/Follow.dart';

class FriendFansPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FriendFansPageState();
}

class _FriendFansPageState extends State<FriendFansPage> {
  @override
  Widget build(BuildContext context) {
    // return Container();
    return ProviderWidget<FriendFansModel>(
        model: FriendFansModel(),
        onModelReady: (model) {
          Map<String, dynamic> formData = {
            'uid': 1521312765,
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
          return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                Follow follow = model.data.followeds[index];
                return _buildFriendItem(follow);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  margin:
                      EdgeInsets.only(top: 0, bottom: 0, left: 184.w, right: 0),
                  child: Center(
                    child: Divider(
                      color: Colors.transparent,
                      height: 0.6,
                    ),
                  ),
                );
              },
              itemCount: model.data.followeds.length);
        });
  }

  Widget _buildFriendItem(Follow follow) {
    return Container(
      padding: EdgeInsets.only(left: 46.w, right: 46.w, top: 10, bottom: 10),

      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 108.w,
                height: 108.w,
                color: Colors.blue,
                child: Image.network(follow.avatarUrl),
              ),
            ),
          ),
          Gaps.hGap15,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(follow.nickname, style: R.style.textDark16),
              Text(follow.signature, style: R.style.textGray10),
            ],
          ),
          Spacer(),
          Container(
            padding:
            EdgeInsets.only(top: 2, bottom: 2, left: 6, right: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 0.5),
              shape: BoxShape.rectangle,
              // 默认值也是矩形
              borderRadius: BorderRadius.circular((20.0)), // 圆角度
            ),
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              '+ 回关',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w100,
                  fontSize: 10),
            ),
          ),
          Gaps.hGap10,
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              size: 18,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
