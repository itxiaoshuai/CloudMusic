import 'package:cloud_music/base/ConstImg.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/model/cloud_list_model.dart';
import '../../r.dart';
import 'package:cloud_music/data/protocol/cloud_storage_bean.dart';

class CloudStoragePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CloudStoragePageState();
}

class _CloudStoragePageState extends State {
  CloudStorageBean _cloudStorageBean;
  CloudListModel _counterProvider = new CloudListModel();

  @override
  Widget build(BuildContext context) {
    // 列表项
    Widget _buildListItem(
      BuildContext context,
      int index,
    ) {
      return Container(
//      color: Colors.redAccent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Gaps.hGap10,
            Text(
              (index + 1).toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Gaps.hGap10,
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
                              _cloudStorageBean.data[index].songName,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
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
                              (_cloudStorageBean.data[index].artist.isEmpty &&
                                      _cloudStorageBean
                                          .data[index].album.isEmpty)
                                  ? "未知"
                                  : "${_cloudStorageBean.data[index].artist}-${_cloudStorageBean.data[index].album}",
                              style: TextStyle(
                                  fontSize: 8, color: Colors.grey[600]),
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
                visible: _cloudStorageBean.data[index].simpleSong.mv > 0,
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

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   iconTheme: IconThemeData(
      //     color: Colors.black, //修改颜色
      //   ),
      //   backgroundColor: Colors.white,
      //   title: Container(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           '音乐云盘',
      //           style: R.style.textBoldDark14,
      //         ),
      //       ],
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Image.asset(
      //         'images/setting.png',
      //         width: 24,
      //       ),
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: Icon(
      //         Icons.search_sharp,
      //         size: 24,
      //         color: Colors.black,
      //       ),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: ProviderWidget<CloudListModel>(
        model: CloudListModel(),
        onModelReady: (model) {
          Map<String, dynamic> formData = {'limit': 30, "offset": 30};
          model.loadData(formData);
        },
        builder: (context, model, child) {
          debugPrint('---当前状态--> ${model}');
          switch (model.layoutState) {
            case LayoutState.IDLE:
              return AppBar(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black, //修改颜色
                ),
                backgroundColor: Colors.white,
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '音乐云盘',
                        style: R.style.textBoldDark14,
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Image.asset(
                      'images/setting.png',
                      width: 24,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search_sharp,
                      size: 24,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ],
              );
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
              _cloudStorageBean = model.data;
              break;
          }

          return CustomScrollView(
            slivers: <Widget>[
              // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
              SliverAppBar(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black, //修改颜色
                ),
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    icon: Image.asset(
                      'images/setting.png',
                      width: 24,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search_sharp,
                      size: 24,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ],
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '音乐云盘',
                        style: R.style.textBoldDark14,
                      ),
                      Text(
                        _cloudStorageBean==null?"": "${NumberUtils.amountCapacity(int.parse(_cloudStorageBean.size))}-${NumberUtils.amountCapacity(int.parse(_cloudStorageBean.maxSize))}",
                        style: R.style.textBoldDark14,
                      ),
                    ],
                  ),
                ),
                pinned: true,
                snap: false,
              ),
              SliverToBoxAdapter(
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
                      // Image.asset(
                      //   'images/play.png',
                      //   color: Colors.red,
                      //   width: 25,
                      // ),
                      Padding(padding: EdgeInsets.only(left: 4)),
                      Text(
                        "播放全部",
                        style: R.style.textBoldDark14,
                      ),
                      Padding(padding: EdgeInsets.only(left: 2)),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: IconButton(
                          icon: Image.asset(
                            ConstImgResource.multipleSelection,
                            width: 20,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ]..removeWhere((v) => v == null),
                  ),
                ),
              ),
              // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(_buildListItem,
                      childCount: model.data.data.length),
                  itemExtent: 60)
            ],
          );
        },
      ),
    );
  }
}
