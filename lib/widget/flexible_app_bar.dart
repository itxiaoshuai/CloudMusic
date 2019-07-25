import 'package:flutter/material.dart';

class FlexibleDetailBar extends StatelessWidget {
  final Widget content;

  const FlexibleDetailBar({
    Key key,
    @required this.content,
  })  : assert(content != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ///InheritedWidget是Flutter的一个功能型的Widget基类，它能有效地将数据在当前Widget树中向它的子widget树传递。
    ///它的子Widget树可以通过 BuildContext.inheritedFromWidgetOfExactType()方法获得最近的指定类型的Inherited widget，
    /// 进而获取它的共享数据
    ///为FlexibleSpaceBar提供大小调整和不透明度信息

    final List<Widget> children = <Widget>[];
    final FlexibleSpaceBarSettings settings =
        context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);

    ///FlexibleDetailBar的高度
    final double deltaExtent = settings.maxExtent - settings.minExtent;
    final double currentExtent = settings.currentExtent;
    print('deltaExtent====$deltaExtent');
    print('currentExtent====$currentExtent');
    // 0.0 -> 收缩
    // 1.0 -> 展开
    final double expandedState =
        ((settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0);
    print('expandedState====$expandedState');
    children.add(Positioned(

    ));
    return content;
  }
}
