import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/model/message_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../../r.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('消息'),
        ),
        body: ProviderWidget<MessageModel>(
            model: MessageModel(),
            onModelReady: (model) {
              model.loadData();
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
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  //圆形渐变
                                  color: Colors.red[400],
                                  shape: BoxShape.circle,
                                  // gradient: const LinearGradient(colors: [
                                  //   Colors.redAccent,
                                  //   Colors.redAccent,
                                  //   Colors.red,
                                  // ]),
                                ),
                                child: Icon(Icons.person),
                              ),
                              Text('粉丝'),
                            ],
                          ),
                          Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteName.PAGE_MESSAGE_COMMENT);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      //圆形渐变
                                      color: Colors.blue[400],
                                      shape: BoxShape.circle,
                                      // gradient: const LinearGradient(colors: [
                                      //   Colors.redAccent,
                                      //   Colors.redAccent,
                                      //   Colors.red,
                                      // ]),
                                    ),
                                    child: Icon(Icons.comment),
                                  ),
                                  Text('评论'),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  //圆形渐变
                                  color: Colors.deepOrangeAccent[100],
                                  shape: BoxShape.circle,
                                  // gradient: const LinearGradient(colors: [
                                  //   Colors.redAccent,
                                  //   Colors.redAccent,
                                  //   Colors.red,
                                  // ]),
                                ),
                                child: Icon(Icons.call_missed_outlined),
                              ),
                              Text('@我'),
                            ],
                          ),
                          Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteName.PAGE_NOTICE);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      //圆形渐变
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                      // gradient: const LinearGradient(colors: [
                                      //   Colors.redAccent,
                                      //   Colors.redAccent,
                                      //   Colors.red,
                                      // ]),
                                    ),
                                    child: Icon(Icons.notifications),
                                  ),
                                  Text('通知'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      children: model.data.map<Widget>((p) {
                        return Container(
                          child: Row(
                            children: [
                              Gaps.hGap15,
                              Center(
                                  child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                    imageUrl: p['fromUser']['avatarUrl'],
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gaps.vGap10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(p['fromUser']['nickname']),
                                      Text(
                                        '${DateUtil.formatDateMs(p['lastMsgTime'], format: 'yyyy年MM月dd日')}',
                                        style: R.style.textGray10,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    json.decode(p['lastMsg'])['msg'],
                                    style: R.style.textGray12,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Gaps.vGap10,
                                  Gaps.line,
                                ],
                              )),
                              Gaps.hGap15,
                            ],
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
