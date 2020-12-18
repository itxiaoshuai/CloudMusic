import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/pages/playllist/page_playlist_detail.dart';

class ListItemCustom extends StatelessWidget {
  final double width; //宽
  final double height; //高
  final double circular; //圆角
  final String img; //图片
  final String updateFrequency;
  final Map album;

  ListItemCustom(
      {this.width = 100,
      this.height = 100,
      this.circular = 6.0,
      this.updateFrequency = "",
      this.img,
      this.album});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
          child: Stack(
        children: <Widget>[
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(circular)),
              color: Color(0xffd6d8da),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 0,
              child: Center(
                  child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(circular),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: img,
                    placeholder: (context, url) => ProgressView(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ))),
          Positioned(
            left: 5,
            bottom: 5,
            child: Text(
              updateFrequency,
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
