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

import '../../../r.dart';

class NoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
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
            "通知",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ProviderWidget<MessageModel>(
            model: MessageModel(),
            onModelReady: (model) {
              model.loadNoticeData();
            },
            child: Container(),
            builder: (context, model, child) {
              switch (model.layoutState) {
                case LayoutState.IDLE:
                  break;
                case LayoutState.LOADING:
                  return ViewStateLoadingWidget();
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
                      children: model.notices.map<Widget>((p) {
                        return Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  RouteName.PAGE_NOTICE_COMMENT,
                                  arguments: p['notice']);
                              debugPrint("详情页面Json数据" + p['notice']);
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Gaps.hGap15,
                                  Center(
                                      child: Container(
                                    child: InkWell(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(35),
                                        child: CachedNetworkImage(
                                          width: 35,
                                          height: 35,
                                          fit: BoxFit.fill,
                                          imageUrl:
                                              json.decode(p['notice'])['user']
                                                  ['avatarUrl'],
                                          placeholder: (context, url) =>
                                              ProgressView(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      onTap: () {
                                        print(
                                            '${json.decode(p['notice'])['user']['avatarUrl']}');
                                        print(
                                            '${json.decode(p['notice'])['user']['userId']}');
                                        // var beRepliedUser = json.decode(
                                        //     p['notice']['beRepliedUser']);
                                        // print(beRepliedUser);
                                        // print(
                                        //     '${json.decode(p['notice']['beRepliedUser']['avatarUrl'])}');
                                        // // print(json.decode(p['userId'])+"");
                                        Navigator.of(context).pushNamed(
                                            RouteName.USER_HOME,
                                            arguments:
                                                json.decode(p['notice'])['user']
                                                    ['userId']);
                                      },
                                    ),
                                  )),
                                  Gaps.hGap15,
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Gaps.vGap10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              json.decode(p['notice'])['user']
                                                  ['nickname'],
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
                                            getText(p),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            '${DateUtil.formatDateMs(p['time'], format: 'yyyy年MM月dd日')}',
                                            style: R.style.textGray10,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        getTextContent(p),
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        json
                                            .decode(p['notice'])['type']
                                            .toString(),
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Gaps.vGap10,
                                      Gaps.line,
                                    ],
                                  )),
                                  Gaps.hGap15,
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

  ///自行扩展，这里只列举两种评论类型
  String getText(p) {
    if (json.decode(p['notice'])['type'] == 6) {
      //评论类型
      return '赞了你的评论:';
    }
    if (json.decode(p['notice'])['type'] == 1) {
      //赞了动态
      return '赞了你的动态:';
    }
    return p.toString();
  }

  String getTextContent(p) {
    if (json.decode(p['notice'])['type'] == 6) {
      //评论类型
      return json.decode(p['notice'])['comment']['content'];
    }
    if (json.decode(p['notice'])['type'] == 1) {
      //赞了动态
      return "我" +
          json.decode(p['notice'])['track']['info']['commentThread']
              ['resourceInfo']['name'];
    }
    return p.toString();
  }
}
