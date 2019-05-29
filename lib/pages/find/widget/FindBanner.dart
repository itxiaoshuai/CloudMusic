import 'package:flutter/material.dart';
import 'package:flutter_app/data/protocol/banner_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// 轮播图
class FindBanner extends StatelessWidget {
  final List<Banners> bannerData;

  FindBanner({this.bannerData});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Banner(bannerData),
        Divider(height: 1),
      ]),
    );
  }
}

class Banner extends StatelessWidget {
  final List<Banners> bannerData;

  Banner(this.bannerData);

  _buildSwipe() {
    Widget widget;
    if (bannerData != null && bannerData.length > 0) {
      widget = Swiper(
        itemBuilder: (BuildContext context, int index) {
          Banners banner = bannerData[index];
//          return Banner(banner);
          return Image.network(
            banner.imageUrl,
            fit: BoxFit.fill,
          );
        },
        itemCount: bannerData.length,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      );
    } else {
      //设置默认控件
      widget = Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xffd6d8da),
        ),
      );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        color: Colors.blue,
        child: Stack(
          children: <Widget>[
            _background(),
          ],
        ));
  }
}

_background() {
  return Positioned(
    // 使用row把背景宽度撑开
    child: Container(
      height: 110,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Color(0xffdd4137),
            ),
          )
        ],
      ),
    ),
  );
}
