import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/data/protocol/BannerBean.dart';
import 'package:cloud_music/data/protocol/new_album.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/pages/find/PageFind.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/pages/find/widget/FindBanner.dart';

import '../../r.dart';
import 'album_digital.dart';

class DigitalAlbumPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DigitalAlbumPageState();
}

bool isDaily = true; //新歌
bool isWeek = false; //新歌
bool isTotal = false; //新歌

class _DigitalAlbumPageState extends State<DigitalAlbumPage> {
  List<BannerBean> _bannerData = [];
  late NewAlbum _album;

  @override
  void initState() {
    getHttp();
    // loadData();
    super.initState();
  }

  Future getHttp() async {
    var dio = Dio();
    var response =
        await dio.get("http://www.mocky.io/v2/5cee0154300000592c6e9825");

    List<BannerBean> banners = BannerList.fromJson(response.data).banners;

    _bannerData = banners;
    if (banners != null && mounted) {
      setState(() {
        _bannerData = banners;
      });
    }
  }

  loadData() async {
    _album = await RequestManager.fetchNewPlate();
    setState(() {});
  }

  _buildDigitalAlbum(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Row(
                  children: [
                    Text('数字专辑榜'),
                    Icon(Icons.chevron_right),
                  ],
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text(
                          '日榜',
                          style:
                              isDaily ? R.style.textRed16 : R.style.textDark16,
                        ),
                        onTap: () {
                          isDaily = true;
                          isWeek = false;
                          isTotal = false;
                          setState(() {});
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        color: Colors.grey,
                        height: 15,
                        width: 1,
                      ),
                      InkWell(
                        child: Text(
                          '周榜',
                          style:
                              isWeek ? R.style.textRed16 : R.style.textDark16,
                        ),
                        onTap: () {
                          isDaily = false;
                          isWeek = true;
                          isTotal = false;
                          setState(() {});
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        color: Colors.grey,
                        height: 15,
                        width: 1,
                      ),
                      InkWell(
                        child: Text(
                          '总榜',
                          style:
                              isTotal ? R.style.textRed16 : R.style.textDark16,
                        ),
                        onTap: () {
                          isDaily = false;
                          isWeek = false;
                          isTotal = true;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AlbumDigitalWidget(),
        ],
      ),
    );
  }

  //最新上架
  _buildNewPlate(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text('新碟上架'),
              Icon(Icons.chevron_right),
            ],
          ),
          _album == null
              ? Container()
              : Container(
                  margin: EdgeInsets.only(top: 15, bottom: 30),
                  child: GridView.builder(
                    shrinkWrap: true,
                    // 添加
                    physics: NeverScrollableScrollPhysics(),
                    // 添加
                    itemCount: _album.albums.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 横轴元素个数
                      childAspectRatio: 0.7, //宽高比为1:2
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      Album album = _album.albums[index];
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Center(
                                  child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(circular)),
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
                                          borderRadius:
                                              BorderRadius.circular(circular),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl: album.blurPicUrl,
                                            placeholder: (context, url) =>
                                                ProgressView(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ))),
                                ],
                              )),
                            ),
                            Text(
                              album.name,
                              style: R.style.textDark16,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              album.artist.name,
                              style: R.style.textGray10,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          FindBanner(bannerData: _bannerData),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: menuList.map((e) {
              return ListItem(
                image: e.img,
                text: e.title,
                route: e.path,
              );
            }).toList(),
          ),
          _buildNewPlate(context),
          _buildDigitalAlbum(context),
          _buildDigitalAlbum(context),
        ],
      ),
    );
  }
}

List<Menu> menuList = <Menu>[
  Menu(
    title: '畅销榜',
    img: R.mipmap.dailySpecial,
    path:RouteName.PAGE_LANGUAGE_STYLE_MUSEUM,
  ),
  Menu(
    title:'语种风格馆',
    img: R.mipmap.fm,
    path:RouteName.PAGE_LANGUAGE_STYLE_MUSEUM,
  ),
  Menu(
    title: '已购',
    img: R.mipmap.playlist,
    path:RouteName.PAGE_LANGUAGE_STYLE_MUSEUM,
  ),
];

class ListItem extends StatelessWidget {
  final String text;
  final String image;
  final String route;

  ListItem({required this.image, required this.text, required this.route});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 45.0,
                  decoration: BoxDecoration(
                    //圆形渐变
                    color: Colors.pink[50]!.withOpacity(0.8),
                    shape: BoxShape.circle,
                    // gradient: const LinearGradient(colors: [
                    //   Colors.redAccent,
                    //   Colors.redAccent,
                    //   Colors.red,
                    // ]),
                  ),
                  child: Image.asset(
                    image,
                    color: Colors.red,
                    width: 50,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: text == '每日推荐'
                      ? Text(
                          '${DateUtil.formatDate(DateTime.now(), format: 'd')}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(''),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 5), //上边距
                child: Text(text,
                    style: TextStyle(
                      fontSize: 12,
                    )))
          ],
        ),
      ),
    );
  }
}
