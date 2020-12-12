import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/CommonLoading.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images =
      List.generate(3, (i) => 'https://picsum.photos/id/$i/800/800');

  ScrollController _scrollController = ScrollController();
  var globalKeyOne = GlobalKey();
  var globalKeyTwo = GlobalKey();
  var globalKeyThree = GlobalKey();
  var oneY = 0.0;
  var twoY = 0.0;
  var threeY = 0.0;

  double getY(BuildContext buildContext) {
    final RenderBox box = buildContext.findRenderObject();
    final size = box.size;
    ////代表的意思是说 button 组件中（0，0）点转换成全屏幕上的点的坐标值
    final topLeftPosition = box.localToGlobal(Offset.zero);
    return topLeftPosition.dy;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      oneY = getY(globalKeyOne.currentContext);
      twoY = getY(globalKeyTwo.currentContext);
      threeY = getY(globalKeyThree.currentContext);

      print('one=$oneY=two=$twoY=three=$threeY');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NotificationListener(
        onNotification: (Notification notification) {
          return false;
        },
        child: ListView(
          controller: _scrollController,
          children: [
            Container(
              key: globalKeyOne,
              child: Center(
                  child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: "https://picsum.photos/id/0/800/800",
                    placeholder: (context, url) => ProgressView(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              )),
            ),
            Container(
              key: globalKeyTwo,
              child: Center(
                  child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: "https://picsum.photos/id/0/800/800",
                    placeholder: (context, url) => ProgressView(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              )),
            ),
            Container(
              key: globalKeyThree,
              child: Center(
                  child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: "https://picsum.photos/id/0/800/800",
                    placeholder: (context, url) => ProgressView(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
    return Scaffold(
      body: NotificationListener(
        onNotification: (Notification notification) {
          print('我的名字叫${_scrollController.position.extentBefore}');
          if (notification is ScrollStartNotification) {
            print('滚动开始');
          }
          if (notification is ScrollUpdateNotification) {
            print('滚动中');
          }
          if (notification is ScrollEndNotification) {
            print('停止滚动');
            if (_scrollController.position.extentAfter == 0) {
              print('滚动到底部');
            }
            if (_scrollController.position.extentBefore == 0) {
              print('滚动到头部');
            }
          }
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                    child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: images[index],
                      placeholder: (context, url) => ProgressView(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                )),
              ),
            );
          },
        ),
      ),
    );
  }
}
