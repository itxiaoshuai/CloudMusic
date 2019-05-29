import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Img extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double radius;
  final Color color;
  final BoxFit fit;
  final bool noSetReqImgSize;

  Img(this.url,
      {this.width: 600,
      this.height: 600,
      this.radius: 4,
      this.noSetReqImgSize: true,
      this.color: Colors.transparent,
      this.fit: BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          child: url == null ? "" : _fadeInImage()),
    );
  }

  _fadeInImage() {
    return FadeInImage(
      width: width,
      height: height,

      image:
          CachedNetworkImageProvider(noSetReqImgSize ? _setReqImgSize() : url),
      fit: fit,
    );
  }



  _setReqImgSize() {
    int imgWidth = (width * 1.6).round();
    int imgHeight = (height * 1.6).round();

    return "$url?imageView=1&thumbnail=${imgWidth}z$imgHeight&type=webp&quality=90";
  }

  getReqImgSize() => _setReqImgSize();
}
