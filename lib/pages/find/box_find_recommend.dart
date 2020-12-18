import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/widget/base_song_img_item.dart';
import 'package:cloud_music/widget/item/DrawerListItem.dart';

import '../page_songlist.dart';
class BoxFindRecommend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoxFindRecommendState();
}

class _BoxFindRecommendState extends State<BoxFindRecommend> {
  var i = 1; //排行榜名次
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.amber,
//      padding: EdgeInsets.only(top: 10, bottom: 10),
        margin: EdgeInsets.only(top: 0, bottom: 6),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              // color: Colors.pink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '推荐歌单',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Center(
                      child: Material(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                              30.0), //如果[borderRadius]被指定，那么[type]属性不能是 [MaterialType.circle]。
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (BuildContext context) {
                              return SongListPage();
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Text(
                                  '更多',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                      fontWeight: FontWeight.w100, fontSize: 14),
                                ),
                                Icon(Icons.chevron_right_rounded),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                padding: EdgeInsets.only(left: 15, right: 15),
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: List.generate(10, (index) {
                      return Row(
                        children: [
                          BaseImgItem(
                            id: 120321112,
                            width: 120,
                            playCount: 7508,
                            img:
                                'http://p4.music.126.net/jpelUV507276mmlQrzYx1g==/109951165533118533.jpg',
                            describe: '泰勒·斯威夫特',
                          ),
                          index == 10 - 1 ? const SizedBox() : Gaps.hGap10,
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
