import 'dart:ui';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/data/protocol/song.dart';
import 'package:cloud_music/data/protocol/tracks.dart';
import 'package:cloud_music/manager/audio_paly_manager.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/ConstImg.dart';
import 'package:cloud_music/base/utils/utils.dart';
import 'package:cloud_music/data/protocol/playlist.dart';
import 'package:cloud_music/model/play_list_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:cloud_music/widget/ListItemCustom.dart';
import 'package:cloud_music/widget/flexible_app_bar.dart';
import 'package:provider/provider.dart';

import '../../r.dart';
import 'item_music_list_track.dart';

class PlaylistDetailPage extends StatefulWidget {
  PlaylistDetailPage(
    this.playlistId,
  );
  final int playlistId;

  @override
  State<StatefulWidget> createState() => _PlayListDetailState();
}

class _PlayListDetailState extends State<PlaylistDetailPage> {
  late Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ProviderWidget<PlayListModel>(
        model: PlayListModel(),
        onModelReady: (model) {
          model.loadData(widget.playlistId);
        },
        child: Container(),
        builder: (context, model, child) {
          debugPrint('---当前状态--> ${model}');
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

          return CustomWidget(model, widget.playlistId);
        },
      ),
    );
  }
}

///播放列表头部背景
class PlayListHeaderBackground extends StatelessWidget {
  final String imageUrl;

  const PlayListHeaderBackground({ required this.imageUrl})
      : super();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(color: Colors.black.withOpacity(0.1)),
        )
      ],
    );
  }
}

/// 播放列表头部
class _PlaylistDetailHeader extends StatelessWidget {
  _PlaylistDetailHeader(this.model, this.id);

  PlayListModel model;
  int id;

  @override
  Widget build(BuildContext context) {
    return FlexibleDetailBar(
      background: PlayListHeaderBackground(
          imageUrl:
             model.data.coverImgUrl),
      content: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Text(''),
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Gaps.hGap15,
                        ListItemCustom(
                          width: 120,
                          height: 120,
                          img: model.data == null ? "" : model.data.coverImgUrl, album: {},
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                model.data == null ? "" : model.data.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                // color: Colors.orangeAccent,
                                margin: const EdgeInsets.only(
                                    left: 0, top: 4, bottom: 4, right: 0),
                                child: InkWell(
                                  onTap: () => {},
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 6, bottom: 6, right: 0),
//                            color: Colors.blue,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              model.data == null
                                                  ? ""
                                                  : model
                                                      .data.creator.avatarUrl,
                                            ),
                                            backgroundColor: Colors.black,
                                            radius: 15.0,
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 6)),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              model.data == null
                                                  ? ""
                                                  : model.data.creator.nickname,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right,
                                          color: Theme.of(context)
                                              .primaryIconTheme
                                              .color,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      // color: Colors.green,
                                      child: Text(
                                        model.data == null
                                            ? ""
                                            : stringFilter(
                                                model.data.description),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gaps.hGap15,
                      ],
                    ),
                    // color: Colors.blue,
                  ),
                  SizedBox(height: 50),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, top: 45, bottom: 5),
                            height: 44,
                            //边框设置
                            decoration: BoxDecoration(
                              //背景
                              color: Colors.white,
                              //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              //设置四周边框
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                Text('含7首VIP专享歌曲'),
                                Spacer(),
                                Text('首开VIP仅5元'),
                                Icon(Icons.chevron_right),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 140,
              left: 50,
              right: 50,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                // 抗锯齿
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                // 阴影大小
                child: Container(
                  height: 44,
                  //边框设置
                  decoration: BoxDecoration(
                    //背景
                    color: Colors.white,
                    //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    //设置四周边框
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Material(
                        child: InkWell(
                          //点击事件回调
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RouteName.comment, arguments: id);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                ConstImgResource.comment,
                                color: Colors.black,
                                width: 20,
                              ),
                              Text(model.data.commentCount.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 0.5,
                        color: Colors.grey[500],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ConstImgResource.comment,
                            color: Colors.black,
                            width: 20,
                          ),
                          Text(model.data.shareCount.toString(),
                              style: TextStyle(
                                fontSize: 12,
                              ))
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 0.5,
                        color: Colors.grey[500],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ConstImgResource.share,
                            color: Colors.black,
                            width: 20,
                          ),
                          Text(model.data.shareCount.toString(),
                              style: TextStyle(
                                fontSize: 12,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class ListItem extends StatelessWidget {
  final String text;
  final String image;

  ListItem({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image,
          color: Colors.black,
          width: 20,
        ),
        Container(
            margin: EdgeInsets.only(top: 5), //上边距
            child: Text(text,
                style: TextStyle(
                  fontSize: 12,
                )))
      ],
    );
  }
}

///音乐列表头
class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  PlayListModel model;

  MusicListHeader(this.model);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
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
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Padding(padding: EdgeInsets.only(left: 2)),
                Text(
                  "(共${model.data.tracks.length}首)",
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),

                IconButton(
                  icon: Image.asset(
                    R.mipmap.download,
                    color: Colors.black,
                    width: 18,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset(
                    R.mipmap.multiple,
                    color: Colors.black,
                    width: 18,
                  ),
                  onPressed: () {},
                )
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

class CustomWidget extends StatelessWidget {
  CustomWidget(this.model, this.id);

  PlayListModel model;
  int id;

  @override
  Widget build(BuildContext context) {
    var audioPlayManager = Provider.of<AudioPlayManager>(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            title: Text(model.data.name),
            elevation: 0,
//            backgroundColor: Colors.transparent,
            pinned: true,
//            floating: true,
//            snap: false,
            expandedHeight: 380.0,

            bottom: _buildListHeader(context, model) as PreferredSizeWidget,
            flexibleSpace: _PlaylistDetailHeader(model, id),
            actions: <Widget>[
              IconButton(
                icon: new Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                tooltip: 'Navigation menu',
                onPressed: null, // null禁用按钮
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ]),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            Tracks track = model.data.tracks[index];
            return Material(
              child: InkWell(
                onTap: () {
                  playSongs(context, audioPlayManager, index);
                },
                child: Container(
                  height: 60,
                  //不要在这里设置背景色，否则会遮挡水波纹效果,如果设置的话尽量设置Material下面的color来实现背景色
                  margin: EdgeInsets.all(0.0),
                  child: TrackItem(
                    index: index + 1,
                    track: track,
                  ),
                ),
              ),
              color: Colors.white,
            );
          }, childCount: model.data.tracks.length //50个列表项
                  ),
        ),
      ],
    );
  }

  Widget _buildListHeader(BuildContext context, PlayListModel model) {
    _PlaylistDetailHeader(this.model, this.id);
    return MusicListHeader(model);
  }

  void playSongs(
      BuildContext context, AudioPlayManager audioPlayManager, int index) {
    // model.data.tracks
    // audioPlayManager.
    Navigator.of(context).pushNamed(RouteName.PAGE_SONGS);
    audioPlayManager.addSongs(model.data.tracks);
    audioPlayManager.playSongByIndex(index);
    // model.playSongs(
    //   model
    //       .map((r) => Song(
    //     r.id,
    //     name: r.name,
    //     picUrl: r.al.picUrl,
    //     artists: '${r.ar.map((a) => a.name).toList().join('/')}',
    //   ))
    //       .toList(),
    //   index: index,
    // );
    // Navigator.of(context).pushNamed(
    //   RouteName.PAGE_SONGS,
    // );
  }
}
