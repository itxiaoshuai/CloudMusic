import 'package:cloud_music/data/protocol/follows.dart';
import 'package:cloud_music/model/friend_attention_list_model.dart';
import 'package:cloud_music/model/friend_fans_list_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FriendFansPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FriendFansPageState();
}

class _FriendFansPageState extends State<FriendFansPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return ProviderWidget<FriendFansModel>(
    //     model: FriendFansModel(),
    //     onModelReady: (model) {
    //       Map<String, dynamic> formData = {
    //         'uid': 1521312765,
    //       };
    //
    //       model.loadData(formData);
    //     },
    //     builder: (context, model, child) {
    //       switch (model.layoutState) {
    //         case LayoutState.IDLE:
    //           break;
    //         case LayoutState.LOADING:
    //           return ViewStateLoadingWidget();
    //           break;
    //         case LayoutState.EMPTY:
    //         // TODO: Handle this case.
    //           break;
    //         case LayoutState.ERROR:
    //         // TODO: Handle this case.
    //           break;
    //         case LayoutState.UNAUTHORIZED:
    //         // TODO: Handle this case.
    //           break;
    //         case LayoutState.SUCCESS:
    //         // TODO: Handle this case.
    //           break;
    //       }
    //       return ListView.separated(
    //           itemBuilder: (BuildContext context, int index) {
    //             Follow follow = model.data.follow[index];
    //             return _buildFriendItem(follow);
    //           },
    //           separatorBuilder: (BuildContext context, int index) {
    //             return Container(
    //               margin:
    //               EdgeInsets.only(top: 0, bottom: 0, left: 184.w, right: 0),
    //               child: Center(
    //                 child: Divider(
    //                   height: 0.6,
    //                 ),
    //               ),
    //             );
    //           },
    //           itemCount: model.data.follow.length);
    //     });
  }
  Widget _buildFriendItem(Follow follow) {
    return Container(
      padding: EdgeInsets.only(left: 46.w, right: 46.w, top: 20, bottom: 20),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(follow.nickname, style: R.style.textDark16),
              // Text('最近发布了新动态', style: R.style.textGray10),
            ],
          ),
        ],
      ),
    );
  }
}