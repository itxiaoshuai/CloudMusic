import 'package:flutter/material.dart';

class RoundImgWidget extends StatelessWidget {
  final String img;
  final double width;
  final BoxFit fit;

  RoundImgWidget(this.img, this.width, {this.fit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(width / 2),
      child: Image.asset(
        img,
        fit: fit,
      ),
    );
  }
}
