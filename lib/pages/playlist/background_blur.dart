import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundBlur extends StatelessWidget {
  final Widget child;
  final String coverPic;
  BackgroundBlur({required this.coverPic,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Image.network(
                  coverPic,
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
            child: IgnorePointer(
              // ignoring: true,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}