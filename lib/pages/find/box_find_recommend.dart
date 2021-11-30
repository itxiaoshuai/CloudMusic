import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/widget/base_song_img_item.dart';
import 'package:cloud_music/widget/item/DrawerListItem.dart';

import '../page_songlist.dart';

class BoxFindRecommend extends StatefulWidget {
  final String text;
  final String route;

  BoxFindRecommend({required this.text, required this.route});
  @override
  State<StatefulWidget> createState() => _BoxFindRecommendState();
}

class _BoxFindRecommendState extends State<BoxFindRecommend> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          // color: Colors.pink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
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
                                  .subtitle1!
                                  .copyWith(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 14),
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
      ],
    ));
  }
}
