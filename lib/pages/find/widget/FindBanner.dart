import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// 轮播图
class FindBanner extends StatelessWidget {
  _buildSwipe() {
    Widget widget = Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          "http://via.placeholder.com/350x150",
          fit: BoxFit.fill,
        );
      },
      itemCount: 3,
      pagination: SwiperPagination(),
      control: SwiperControl(),
    );
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildSwipe();
  }
}
