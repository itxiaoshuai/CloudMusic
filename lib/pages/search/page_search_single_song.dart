import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/model/search_model.dart';
import 'package:cloud_music/pages/my/PageMy.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:flutter/material.dart';

import '../../r.dart';

class SearchSingleSongPage extends StatefulWidget {
  SearchSingleSongPageState createState() => SearchSingleSongPageState();
}

class SearchSingleSongPageState extends State<SearchSingleSongPage>  with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<SearchModel>(
          model: SearchModel(),
          onModelReady: (model) {
            Map<String, dynamic> formData = {'keywords': "四季予你", "type": 1};
            model.loadSearch(formData);
          },     child: Container(),
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
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    //返回组件集合
                    List.generate(1, (int index) {
                      //返回 组件
                      return Container(
                        color: Colors.white,
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              print(
                                  '###########################点击了##################################');
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.cyan[100 * (index % 9)],
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(left: 16)),
                                    IconButton(
                                      icon: Image.asset(
                                        'images/play.png',
                                        width: 25,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 4)),
                                    Text(
                                      "播放全部",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 2)),
                                    Spacer(),
                                    IconButton(
                                        icon: Image.asset(
                                          R.mipmap.multiple,
                                          width: 20,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {}),
                                    Gaps.hGap16,
                                  ]..removeWhere((v) => v == null),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    //返回组件集合
                    List.generate(model.searchResultList.length, (int index) {
                      //返回 组件
                      return Container(
                        color: Colors.white,
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              print(
                                  '###########################点击了##################################');
                            },
                            child: Container(
                              height: 60,
                              //不要在这里设置背景色，否则会遮挡水波纹效果,如果设置的话尽量设置Material下面的color来实现背景色
                              margin: EdgeInsets.all(0.0),
                              child: TrackItem(model.searchResultList[index]),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TrackItem extends StatefulWidget {
  TrackItem(this.song);

  final song;

  @override
  _TrackItemState createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  String getText() {
    StringBuffer stringBuffer = new StringBuffer();
    var length = widget.song['ar'].length;
    widget.song['ar'].forEach((item) {
      if (length == 1) {
        stringBuffer.write(item['name']);
      }
      if (length > 1) {
        stringBuffer.write(item['name']);
        stringBuffer.write('/');
      }

      length--;
    });
    if (widget.song['al'] != null) {
      if (widget.song['al']['name'] != null) stringBuffer.write('-');
      stringBuffer.write(widget.song['al']['name']);
    }

    return stringBuffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                width: 40,
                height: 40,
                fit: BoxFit.fill,
                imageUrl: widget.song['al']['picUrl'],
                placeholder: (context, url) => ProgressView(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Container(
//              color: Colors.amberAccent,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
                  children: [
                    Expanded(
                      child: Container(
//                      color: Colors.green,
                          child: Center(
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            widget.song['name'],
                            style: TextStyle(fontSize: 12, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                    ),
                    Expanded(
                      child: Container(
//                      color: Colors.green,
                          child: Center(
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            getText(),
                            style:
                                TextStyle(fontSize: 8, color: Colors.grey[600]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                    ),
                  ]),
            ),
          ),
          Container(
//            color: Colors.blue,
            child: Visibility(
              child: IconButton(
                  iconSize: 25,
                  icon: ImageIcon(AssetImage("images/album/track_mv.png")),
                  color: Colors.grey[500],
                  onPressed: () {}),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: widget.song['mv'] > 0,
            ),
          ),
          Container(
//            color: Colors.red,
            child: IconButton(
                iconSize: 15,
                icon: ImageIcon(AssetImage("images/album/track_more.png")),
                color: Colors.grey[500],
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 406.0,
                        child: BottomSheetWidget(),
                      );
                    },
                  ).then((val) {
                    print(val);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
