import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SongListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomWidget(),
    );
//    return CustomWidget();
  }
}

class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            elevation: 0,
//            backgroundColor: Colors.transparent,
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 240.0,
            bottom: _buildListHeader(context),
//            flexibleSpace: _PlaylistDetailHeader(widget.playlist),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_circle),
                tooltip: 'Add new entry',
                onPressed: () {
                  /* ... */
                },
              ),
            ]),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            //创建列表项
            return Material(
              child: new InkWell(
                onTap: () {
                  print(
                      '###########################点击了##################################');
                },
                child: new Container(
                  height: 60,
                  //不要在这里设置背景色，否则会遮挡水波纹效果,如果设置的话尽量设置Material下面的color来实现背景色
                  margin: EdgeInsets.all(0.0),
                  child: TrackItem(index: index + 1),
                ),
              ),
              color: Colors.white,
            );
          }, childCount: 50 //50个列表项
                  ),
        ),
//        SliverFixedExtentList(
//          itemExtent: 50.0,
//          delegate: SliverChildBuilderDelegate(
//            (BuildContext context, int index) {
//              return InkWell(
//                onTap: () {
//                  Fluttertoast.showToast(
//                      msg: "请先勾选同意\"" "用户协议\"" "和\"" "隐私政策\"" "",
//                      toastLength: Toast.LENGTH_SHORT,
//                      gravity: ToastGravity.CENTER,
//                      timeInSecForIos: 1,
//                      textColor: Colors.white);
//                },
//                child: TrackItem(),
//              );
//            },
//          ),
//        ),
      ],
    );
  }

  Widget _buildListHeader(BuildContext context) {
    return MusicListHeader();
  }
}

///单个歌曲(item)
class TrackItem extends StatelessWidget {
  final int index;

  TrackItem({
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.redAccent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              index.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey),
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
                            '有一种悲伤',
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
                            '比悲伤更悲伤的故事 比悲伤更悲伤的故事 电影原声带',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
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
            child: IconButton(
                iconSize: 25,
                icon: ImageIcon(AssetImage("images/album/track_mv.png")),
                color: Colors.grey[500],
                onPressed: () {}),
          ),
          Container(
//            color: Colors.red,
            child: IconButton(
                iconSize: 15,
                icon: ImageIcon(AssetImage("images/album/track_more.png")),
                color: Colors.grey[500],
                onPressed: () {}),
          ),
//          Column(
////              crossAxisAlignment: CrossAxisAlignment.start,
////              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
////                Spacer(),
//
//                Text(
//
//                  '有一种悲伤vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv',
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
//                  style: TextStyle(fontSize: 16, color: Colors.black),
//                ),
//
//              Expanded(
//                child: Container(
//                    color: Colors.green,
//                    child: Center(
//                      child: Align(
//                        alignment: FractionalOffset.centerLeft,
//                        child: Text(
//                          '比悲伤更悲伤的故事 电影原声带cccvvvvvvvvvvvvvvvvvvvvvvvvv',
//                          style: TextStyle(
//                            fontSize: 14,
//                          ),
//                          overflow: TextOverflow.fade,
//                        ),
//                      ),
//                    )),
//              ),
//              Padding(padding: EdgeInsets.only(top: 3)),
//              Container(
//                color: Colors.red,
//
//                child: Row(),
//                    child: Text(
//                      '比悲伤更悲伤的故事 电影原声带cccccccccccccccccccccccccccccccc',
//                      maxLines: 1,
//                      overflow: TextOverflow.ellipsis,
//                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                    ),
//              ),
////                Spacer(),
//            ],
//          ),
        ],
      ),
    );
  }
}

///音乐列表头
class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        color: Colors.white,
        elevation: 0,
        child: InkWell(
          child: SizedBox.fromSize(
            size: preferredSize,
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 16)),
                Icon(
                  Icons.play_circle_outline,
                  color: Theme.of(context).iconTheme.color,
                ),
                Padding(padding: EdgeInsets.only(left: 4)),
                Text(
                  "播放全部",
                  style: Theme.of(context).textTheme.body1,
                ),
                Padding(padding: EdgeInsets.only(left: 2)),
                Text(
                  "(共首)",
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
              ]..removeWhere((v) => v == null),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
