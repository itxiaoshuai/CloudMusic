import 'package:flutter/material.dart';

class RoundImgWidget extends StatelessWidget {
  final String img;
  final double width;
  final BoxFit fit;

  RoundImgWidget(this.img, this.width, {this.fit});

  @override
  Widget build(BuildContext context) {
    return img.startsWith('http') || img.startsWith('https') ?
    CircleAvatar(
      backgroundImage: NetworkImage(
        'http://p3.music.126.net/JL0hXL3TNcjcfi0uJTKM-A==/109951163300299605.jpg',
      ),
      backgroundColor: Colors.black,
      radius: width/2,
    ):ClipRRect(
      borderRadius: BorderRadius.circular(width / 2),
      child:Image.asset(
        img,
        fit: fit,
      ),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(width / 2),
      child: img.startsWith('http')
          ? Image(image: NetworkImage(img), fit: BoxFit.cover)
          : Image.asset(
              img,
              fit: fit,
            ),
    );
  }
}
