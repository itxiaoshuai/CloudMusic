import 'package:flutter/material.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';

///单个歌曲(item)
class TrackItem extends StatelessWidget {
  final int index;
  final Tracks tracks;

  TrackItem({this.index, this.tracks});

  String getText(Tracks tracks) {
    StringBuffer stringBuffer = new StringBuffer();
    var length = tracks.ar.length;
    tracks.ar.forEach((item) {
      if (length == 1) {
        stringBuffer.write(item.name);
      }
      if (length > 1) {
        stringBuffer.write(item.name);
        stringBuffer.write('/');
      }

      length--;
    });
    if (tracks.al != null) {
      if (tracks.al.name != null) stringBuffer.write('-');
      stringBuffer.write(tracks.al.name);
    }

    return stringBuffer.toString();
  }

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
                            tracks.name,
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
                            getText(tracks),
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
        ],
      ),
    );
  }
}
