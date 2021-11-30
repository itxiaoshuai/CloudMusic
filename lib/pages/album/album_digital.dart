//数字专辑榜
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/data/api/apis.dart';
import 'package:cloud_music/net/http.dart';
import 'package:flutter/material.dart';

class AlbumDigitalWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumDigitalWidgetState();
  }
}

class _AlbumDigitalWidgetState extends State<AlbumDigitalWidget> {
  bool isNewSong = true; //新歌
  List _newSong = [];
  List _newAlbum = [];
  double circular = 6;
  List _newAlbumSale = [];

  @override
  void initState() {
    // getNewSongList();
    // getNewAlbumList();
    getAlbumList();
    super.initState();
  }

  Future getNewSongList() async {
    Map<String, dynamic> formData = {
      'limit': 6,
    };
    var response =
        await Http().get(MusicApi.NewSong, queryParameters: formData);
    print(response);
    List rows = response.data['result'];
    _newSong = rows;
    setState(() {});
  }

  //新碟
  Future getNewAlbumList() async {
//    Map<String, dynamic> formData = {
//      'limit': 6,
//    };
    var response = await Http().get(MusicApi.ALBUM_SONG_SALE_BOARD);
    print(response);
    List rows = response.data['albums'];
    _newAlbumSale = rows;
    setState(() {});
  }

  //新碟
  Future getAlbumList() async {
    Map<String, dynamic> formData = {
      'limit': 12,
      'offset': 30,
      'albumType': "1",
      'type': "year",
      'year': 2020,
    };
    var response = await Http()
        .get(MusicApi.ALBUM_SONG_SALE_BOARD, queryParameters: formData);
    print(response);
    List rows = response.data['products'];
    _newAlbumSale = rows;
    print(_newAlbumSale);
    setState(() {});
  }

  Widget _buildAlbum(BuildContext context) {
    return Container(
      child: Column(
        children: _newAlbumSale.sublist(0, 4).map((e) {
          return Container(
            height: 60,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Center(
                    child: Container(
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(circular),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: e['coverUrl'],
                      placeholder: (context, url) => ProgressView(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                )),
                Expanded(
                  child: Container(
//                                color: Colors.amberAccent,
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 8),
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
                                  e['albumName'],
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )),
                          ),
                          Expanded(
                            child: Container(
//                                            color: Colors.green,
                                child: Center(
                              child: Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Text(
                                  e['artistName'],
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
                  padding:
                      EdgeInsets.only(top: 2, bottom: 2, left: 15, right: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 0.5),
                    shape: BoxShape.rectangle,
                    // 默认值也是矩形
                    borderRadius: BorderRadius.circular((20.0)), // 圆角度
                  ),
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    '支持',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w100,
                        fontSize: 12),
                  ),
                ),
                Gaps.hGap15,
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
        height: 240,
        child: PageView(
          controller: PageController(
              initialPage: 0, viewportFraction: (width - 30) / width),
          children: [
            _buildAlbum(context),
            _buildAlbum(context),
            _buildAlbum(context),
          ],
        ));
  }
}
