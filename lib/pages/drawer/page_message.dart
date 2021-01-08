import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/model/message_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
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
        appBar: AppBar(),
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
                                placeholder: (context, url) => ProgressView(),
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
                ),
              );
            }));
  }
}
