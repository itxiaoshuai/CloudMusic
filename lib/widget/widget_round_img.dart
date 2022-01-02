import 'package:flutter/material.dart';

class RoundImgWidget extends StatelessWidget {
  final String img;
  final double width;
  final BoxFit fit;

  RoundImgWidget(this.img, this.width, {this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return img.startsWith('http') || img.startsWith('https')
        ? CircleAvatar(
            backgroundImage: NetworkImage(
              img,
            ),
            backgroundColor: Colors.black,
            radius: width / 2,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(width / 2),
            child: Image.asset(
              img,
              fit: fit,
            ),
          );
  }
}
