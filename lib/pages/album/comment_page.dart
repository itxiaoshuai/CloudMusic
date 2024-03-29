import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_music/base/ConstImg.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/data/protocol/comment_list.dart';
import 'package:cloud_music/model/comment_list_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentPage extends StatefulWidget {
  CommentPage(
    this.playlistId,
  );
  final int playlistId;

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommentList commentList;

    return Scaffold(
      appBar: AppBar(),
      body: ProviderWidget<CommentListModel>(
          model: CommentListModel(),
          child: Container(),
          onModelReady: (model) {
            Map<String, dynamic> formData = {
              'id': widget.playlistId,
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
                  Comment comment = model.data.comments[index];
                  return buildCommentItem(comment);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: 0, bottom: 0, left: 110.w, right: 0),
                    child: Center(
                      child: Divider(
                        height: 0.6,
                      ),
                    ),
                  );
                },
                itemCount: model.data.comments.length);
          }),
    );
  }

  Widget buildCommentItem(Comment comment) {
    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteName.USER_HOME,
                      arguments: comment.user.userId);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    color: Colors.blue,
                    child: Image.network(comment.user.avatarUrl),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user.nickname,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    DateUtil.formatDateMs(comment.time,
                        format: "yyyy/M/d HH:mm:ss"),
                    style: TextStyle(fontSize: 10, color: Colors.black38),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                child: Text(
                    '${NumberUtils.amountConversion(comment.likedCount)}',
                    style: TextStyle(fontSize: 12, color: Colors.black38)),
              ),
              SizedBox(width: 10.w),
              Image.asset(
                ConstImgResource.praise,
                width: 28.w,
                color: Colors.grey,
              )
            ],
          ),
          SizedBox(height: 30.w),
          Container(
            margin: EdgeInsets.only(left: 90.w),
            child: Text(comment.content),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
