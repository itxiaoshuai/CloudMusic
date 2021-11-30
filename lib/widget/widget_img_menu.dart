import 'package:flutter/material.dart';

class ImageTapWidget extends StatefulWidget {
  final String imgNormal;
  final String imgTap;
  final double size;
  final VoidCallback onTap;

  // final Widget child;
  ImageTapWidget(
    this.imgNormal,
    this.imgTap,
    this.size, {
    required this.onTap,
  });

  @override
  _ImageTapWidgetState createState() => _ImageTapWidgetState();
}

class _ImageTapWidgetState extends State<ImageTapWidget> {
  var isDown = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (d) => setState(() => this.isDown = true),
        onTapUp: (d) => setState(() => this.isDown = false),
        onTapCancel: () => setState(() => this.isDown = false),
        child: isDown
            ? Image.asset(
                widget.imgTap,
                width: widget.size,
                height: widget.size,
              )
            : Image.asset(
                widget.imgNormal,
                width: widget.size,
                height: widget.size,
              ),
      ),
    );
  }
}
