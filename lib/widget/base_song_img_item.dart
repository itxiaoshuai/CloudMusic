import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/ConstImg.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/pages/playlist/page_playlist_detail.dart';

class BaseImgItem extends StatelessWidget {
  final double width; //宽
  final double height; //高
  final double circular; //圆角
  final String img; //图片
  final String updateFrequency; //每周几更新
  final String describe; //描述
  final int playCount;
  final int id;

  BaseImgItem({
    this.width = 0,
    this.height = 0,
    this.circular = 6.0,
    this.updateFrequency = "",
    this.img = "",
    this.describe = '',
    this.playCount = 0,
    this.id=0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlaylistDetailPage(id);
        }));
      },
      child: Container(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: width,
              width: width,
              child: Stack(
                children: [
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
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ))),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Row(
                      children: [
                        Image.asset(
                          ConstImgResource.playNum,
                          width: 10,
                          height: 10,
                        ),
                        Text('${NumberUtils.amountConversion(playCount)}',
                            style:
                                TextStyle(fontSize: 10, color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 4)),
            Text(
              describe,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PlaylistDetailPage(id);
          }));
        },
        child: Container(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: width,
                width: width,
                child: Stack(
                  children: [
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
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ))),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Row(
                        children: [
                          Image.asset(
                            ConstImgResource.playNum,
                            width: 10,
                            height: 10,
                          ),
                          Text('${NumberUtils.amountConversion(playCount)}',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 4)),
              Text(
                describe,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
