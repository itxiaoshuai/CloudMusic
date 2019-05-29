import 'package:flutter/material.dart';
import 'package:flutter_app/data/protocol/banner_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// 轮播图
class FindBanner extends StatelessWidget {
  final List<Banners> bannerData;

  FindBanner({this.bannerData});

  _buildSwipe() {
    Widget widget;
    if (bannerData != null && bannerData.length > 0) {
      widget = Swiper(
        itemBuilder: (BuildContext context, int index) {
          Banners banner = bannerData[index];
          return Banner(banner);
//          return Image.network(
//            banner.imageUrl,
//            fit: BoxFit.fill,
//          );
        },
        itemCount: bannerData.length,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      );
    } else {
      widget = Container(
        child: Text('xxxxxxx'),
        color: Colors.cyan,
      );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildSwipe();
  }
}

class Banner extends StatelessWidget {
  final Banners data;

  Banner(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
        child: Container(

          color: Colors.yellowAccent,
        ));
  }
}
