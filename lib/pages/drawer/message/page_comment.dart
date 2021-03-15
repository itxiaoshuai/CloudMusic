import 'dart:convert';

import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/model/comment_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../r.dart';

class PageComment extends StatefulWidget {
  PageComment();

  @override
  State<StatefulWidget> createState() => _PageCommentState();
}

class _PageCommentState extends State<PageComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //修改颜色
          ),
          backgroundColor: Colors.white,
          title: Text(
            "评论",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ProviderWidget<CommentModel>(
            model: CommentModel(),
            onModelReady: (model) {
              model.loadNoticeData();
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
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                      children: model.comments.map<Widget>((p) {
                        return Material(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              child: Column(
                                children: [
                                  Gaps.vGap15,
                                  Container(
                                    child: Row(
                                      children: [
                                        Center(
                                            child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            child: CachedNetworkImage(
                                              width: 35,
                                              height: 35,
                                              fit: BoxFit.fill,
                                              imageUrl: p['user']['avatarUrl'],
                                              placeholder: (context, url) =>
                                                  ProgressView(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(left: 25),
                                        )),
                                        Gaps.hGap15,
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    p['user']['nickname'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                  constraints: BoxConstraints(
                                                    maxWidth: 80,
                                                  ),
                                                ),
                                                Text(
                                                  '${DateUtil.formatDateMs(p['time'], format: 'yyyy年MM月dd日')}',
                                                  style: R.style.textGray10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                        Gaps.hGap15,
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 75, right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '回复我：${p['content']}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Gaps.vGap10,
                                        Container(
                                          padding: EdgeInsets.all(10.0),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            // 底色
                                            //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                                            shape: BoxShape.rectangle,
                                            // 默认值也是矩形
                                            borderRadius: BorderRadius.circular(
                                                (5)), // 圆角度
                                          ),
                                          // margin: EdgeInsets.only(left: 15, right: 15),
                                          child: Container(
                                            child: Text(
                                              '${p['beRepliedContent']}',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 0, left: 75, right: 0),
                                    child: Center(
                                      child: Divider(
                                        height: 0.6,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        return Material(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gaps.hGap15,
                                  Center(
                                      child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: CachedNetworkImage(
                                        width: 35,
                                        height: 35,
                                        fit: BoxFit.fill,
                                        imageUrl: p['user']['avatarUrl'],
                                        placeholder: (context, url) =>
                                            ProgressView(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  )),
                                  Gaps.hGap15,
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Gaps.vGap15,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              p['user']['nickname'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            constraints: BoxConstraints(
                                              maxWidth: 80,
                                            ),
                                          ),
                                          Text(
                                            '${DateUtil.formatDateMs(p['time'], format: 'yyyy年MM月dd日')}',
                                            style: R.style.textGray10,
                                          ),
                                        ],
                                      ),
                                      Gaps.vGap10,
                                      Text(
                                        '回复我：${p['content']}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Gaps.vGap10,
                                      Container(
                                        padding: EdgeInsets.all(10.0),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          // 底色
                                          //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                                          shape: BoxShape.rectangle,
                                          // 默认值也是矩形
                                          borderRadius:
                                              BorderRadius.circular((5)), // 圆角度
                                        ),
                                        // margin: EdgeInsets.only(left: 15, right: 15),
                                        child: Container(
                                          child: Text(
                                            '${p['beRepliedContent']}',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Gaps.vGap10,
                                      Gaps.line2,
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                  ],
                ),
              );
            }));
  }
}
