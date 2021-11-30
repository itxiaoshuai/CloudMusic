import 'package:flutter/material.dart';

enum CloudPasswordInputTextFieldType { BOXES, SEGMENTED }
enum CloudPasswordInputTextFieldBoxType { LINE, BOX }

class CloudPasswordInputTextField extends StatefulWidget {
  final CloudPasswordInputTextFieldType type; //格子样式
  final Function onChange;
  final int length; //输入长度
  final TextEditingController controller; //输入控制器
  final FocusNode node; //焦点
  final double boxWidth; //格子宽
  final double boxHeight; //格子高
  final double borderWidth; //边框宽
  final double borderRaiuds; //圆角
  final Color borderColor; //边框颜色
  final Color fillColor; //填充颜色
  final Color backgroundColor; //填充颜色
  final double spacing; //格子间隔
  final bool obscureText; //是否密文
  final String obscureTextString; //密文字符
  final TextStyle textStyle; //文本样式
  final CloudPasswordInputTextFieldBoxType boxType; //盒子类型
  const CloudPasswordInputTextField({
    this.boxType = CloudPasswordInputTextFieldBoxType.BOX,
    this.type = CloudPasswordInputTextFieldType.BOXES,
    required this.onChange,
    this.length = 6,
    required this.controller,
    required this.node,
    this.boxWidth = 40,
    this.boxHeight = 50,
    this.borderRaiuds = 5.0,
    this.borderColor = Colors.grey,
    this.spacing = 10,
    this.borderWidth = 1.0,
    this.obscureText = false,
    required this.textStyle,
    this.obscureTextString = "●",
    this.fillColor = Colors.white,
    this.backgroundColor = Colors.white,
  }) : super();

  @override
  _CloudPasswordInputTextFieldState createState() =>
      _CloudPasswordInputTextFieldState();
}

class _CloudPasswordInputTextFieldState
    extends State<CloudPasswordInputTextField> {
  List titles = [];

  Widget box() {
    List<Widget> children = [];
    for (var i = 0; i < widget.length; i++) {
      String title = " ";
      if (titles.length > i) {
        title = widget.obscureText ? widget.obscureTextString : titles[i];
      }
      Border? border;
      BorderRadius? borderRadius;
      double itemWidth = widget.boxWidth;
      double itemHeight = widget.boxHeight;
      if (widget.type == CloudPasswordInputTextFieldType.BOXES) {
        borderRadius = BorderRadius.circular(widget.borderRaiuds);
        border =
            Border.all(width: widget.borderWidth, color: widget.borderColor);
      } else if (widget.type == CloudPasswordInputTextFieldType.SEGMENTED) {
        BorderSide side =
            BorderSide(width: widget.borderWidth, color: widget.borderColor);
        Radius radius = Radius.circular(widget.borderRaiuds);
        if (i == 0) {
          itemWidth += 5;
          borderRadius = BorderRadius.only(topLeft: radius, bottomLeft: radius);
          border = Border(left: side, bottom: side, top: side, right: side);
        } else if (i == widget.length - 1) {
          itemWidth += 5;
          borderRadius =
              BorderRadius.only(topRight: radius, bottomRight: radius);
          border = Border(left: side, bottom: side, top: side, right: side);
        } else if (i == widget.length - 2) {
          border = Border(bottom: side, top: side);
        } else {
          border = Border(bottom: side, top: side, right: side);
        }
      }

      Widget item = Container();
      if (widget.boxType == CloudPasswordInputTextFieldBoxType.BOX) {
        item = Container(
          height: itemHeight,
          width: itemWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.fillColor,
              borderRadius: borderRadius,
              border: border),
          child: Text(
            title,
            style: widget.textStyle,
          ),
        );
      }
      if (widget.boxType == CloudPasswordInputTextFieldBoxType.LINE) {
        item = Container(
            child: Center(
              child: Text(
                title,
                style: widget.textStyle,
              ),
            ),
            height: itemHeight,
            width: itemWidth,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
//              border: Border.all(color: Colors.grey,width: 0.5),

//              borderRadius: BorderRadius.circular(5),
                ));
      }

      children.add(item);
    }

    BoxDecoration decoration = BoxDecoration(color: widget.backgroundColor);
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            child: Container(
              width: 10,
              // alignment: Alignment.center,
              child: TextField(
                controller: widget.controller,
                focusNode: widget.node,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text.length > widget.length) {
                    widget.controller.text = text.substring(0, widget.length);
                  }
                  titles = text.split("");
                  widget.onChange(widget.controller.text);
                  setState(() {});
                },
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              widget.node.requestFocus();
            },
            child: Container(
                color: Colors.blue,
                width: double.infinity,
                child: Container(
                    width: widget.length * widget.boxWidth,
                    decoration: decoration,
                    child: widget.type == CloudPasswordInputTextFieldType.BOXES
                        ? Wrap(
                            alignment: WrapAlignment.center,
                            spacing: widget.spacing,
                            children: children,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: children,
                          ))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget box1 = box();
    return Container(
      color: widget.backgroundColor,
      child: box1,
    );
  }
}
