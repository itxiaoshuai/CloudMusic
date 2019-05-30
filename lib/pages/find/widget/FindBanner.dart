import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/CommonLoading.dart';
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
        BannerParent(bannerData, context),
      ]),
    );
  }
}

class BannerParent extends StatelessWidget {
  final List<Banners> bannerData;
  final BuildContext context;

  BannerParent(this.bannerData, this.context);

  _buildSwipe() {
    Widget widget;
    if (bannerData != null && bannerData.length > 0) {
      widget = Swiper(
        itemBuilder: (BuildContext context, int index) {
          Banners banner = bannerData[index];
          return BannerItem(banner: banner);
        },
        layout: SwiperLayout.DEFAULT,
        itemCount: bannerData.length,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
          size: 6,
          activeSize: 6,
          color: Theme.of(context).primaryColor,
          activeColor: Colors.grey[500],
        )),
        autoplay: true,
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
        height: 120,
        child: Stack(
          children: <Widget>[_background(context), _buildSwipe()],
        ));
  }
}

//Expanded组件可以使Row、Column、Flex等子组件在其主轴方向上展开并填充可用空间(例如，Row在水平方向，Column在垂直方向)
_background(BuildContext context) {
  return Positioned(
    child: Container(
      height: 90,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor, //这里使用主题色,随主题切换变化
            ),
          )
        ],
      ),
    ),
  );
}

//单个轮播图控件样式
class BannerItem extends StatelessWidget {
  final Banners banner;

  BannerItem({this.banner});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    width: 600,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: banner.imageUrl,
                        placeholder: (context, url) => ProgressView(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                  ))),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  )),
                  child: Text(
                    banner.typeTitle,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
            ],
          )),
      onTap: () {},
    );
  }
}
