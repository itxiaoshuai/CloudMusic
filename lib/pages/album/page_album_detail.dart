import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/ConstImg.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/data/protocol/comment_list.dart';
import 'package:cloud_music/model/digital_album_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../r.dart';

class AlbumDetailPage extends StatefulWidget {
  var albumId;

  AlbumDetailPage({this.albumId});

  @override
  State<StatefulWidget> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ProviderWidget<DigitalAlbumModel>(
          model: DigitalAlbumModel(),
          child: Container(),
          onModelReady: (model) {
            Map<String, dynamic> formData = {
              'id': widget.albumId,
            };
            model.loadAlbumDetail(formData);
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                R.mipmap.logo,
                                width: 25,
                                height: 25,
                              ),
                              Text('网易云音乐'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('弹幕'),
                              Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: this.flag,
                                  activeColor: Colors.red,
                                  onChanged: (value) {
                                    setState(() {
                                      this.flag = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        width: 250,
                        // color: Colors.green,
                        child: Center(
                          child: Stack(
                            children: [
                              Positioned(
                                right: -10,
                                child: Container(
                                  // margin: EdgeInsets.only(left: 200),
                                  child: Image.asset(
                                    R.mipmap.album,
                                    height: 200,
                                  ),
                                ),
                              ),
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fitHeight,
                                      height: 200,
                                      width: 250,
                                      imageUrl: model.albumDetail['album']
                                          ['coverUrl'],
                                      placeholder: (context, url) =>
                                          ProgressView(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                // padding: EdgeInsets.only(left: 50,right: 50),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(model.albumDetail['album']['albumName']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(model.albumDetail['album']['artistName']),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                      Gaps.line,
                      Container(
                        child: LayoutBuilder(builder: (context, constraints) {
                          int count = 2;
                          double spacing = 15;
                          double totalWidthSpacing = spacing * (count + 1);
                          double width =
                              ((constraints.maxWidth - totalWidthSpacing) ~/
                                      count)
                                  .toDouble();
                          print(width);
                          return Padding(
                            padding: EdgeInsets.only(left: spacing),
                            child: Wrap(
                              spacing: spacing,
                              direction: Axis.horizontal,
                              children: model.albumDetail['product']['tags']
                                  .map<Widget>((p) {
                                return Container(
                                  width: width,
                                  child: Text(p),
                                );
                              }).toList(),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                AlbumDetailCommentPage(
                  albumId: widget.albumId,
                ),
              ],
            );
          }),
    );
  }
}

class AlbumDetailCommentPage extends StatefulWidget {
  final albumId;

  AlbumDetailCommentPage({this.albumId});

  @override
  State<StatefulWidget> createState() => _AlbumDetailCommentPageState();
}

class _AlbumDetailCommentPageState extends State<AlbumDetailCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: ProviderWidget<DigitalAlbumModel>(
            model: DigitalAlbumModel(),
            onModelReady: (model) {
              Map<String, dynamic> formData = {
                'id': 121134358,
              };

              model.loadAlbumComment(formData);
            },
            child: Container(),
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
              // return Container(
              //   child: Column(
              //     children: model.responseAlbumComment.data['comments'],
              //   ),
              // );

              return Column(
                children: model.responseAlbumComment.data['comments']
                    .map<Widget>((p) {
                  return Container(
                    padding: EdgeInsets.only(left: 46.w, right: 46.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.of(context).pushNamed(RouteName.USER_HOME,
                                //     arguments: comment.user.userId);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: 108.w,
                                  height: 108.w,
                                  // color: Colors.blue,
                                  child: Image.network(p['user']['avatarUrl']),
                                ),
                              ),
                            ),
                            SizedBox(width: 30.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p['user']['nickname'],
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                Text(
                                  DateUtil.formatDateMs(p['time'],
                                      format: "yyyy/M/d HH:mm:ss"),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black38),
                                ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(10)),
                              child: Text(
                                  '${NumberUtils.amountConversion(p['likedCount'])}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black38)),
                            ),
                            SizedBox(width: 17.w),
                            Image.asset(
                              ConstImgResource.praise,
                              width: 44.w,
                              height: 44.h,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          margin: EdgeInsets.only(left: 138.w),
                          child: Text(p['content']),
                        ),
                        SizedBox(height: 50.h),
                        Gaps.line,
                      ],
                    ),
                  );
                }).toList(),
              );
            }));
  }

  Widget buildCommentItem(Comment comment) {
    return Container(
      padding: EdgeInsets.only(left: 46.w, right: 46.w),
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
                    width: 108.w,
                    height: 108.w,
                    // color: Colors.blue,
                    child: Image.network(comment.user.avatarUrl),
                  ),
                ),
              ),
              SizedBox(width: 30.w),
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
              SizedBox(width: 17.w),
              Image.asset(
                ConstImgResource.praise,
                width: 44.w,
                height: 44.h,
                color: Colors.grey,
              )
            ],
          ),
          SizedBox(height: 30.h),
          Container(
            margin: EdgeInsets.only(left: 138.w),
            child: Text(comment.content),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
