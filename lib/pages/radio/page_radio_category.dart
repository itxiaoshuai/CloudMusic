import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/data/protocol/RadioCategoryData.dart';
import 'package:cloud_music/net/http.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioCategoryPage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {}

  RadioCategoryPageState createState() => RadioCategoryPageState();
}

class RadioCategoryPageState extends State<RadioCategoryPage> {
  List<Category> mData = [];

  @override
  initState() {
    initData();
    super.initState();
  }

  Future initData() async {
    var response = await http.get('/dj/catelist');

    var data = RadioCategoryData.fromJson(response.data);

    if (response != null && mounted) {
      setState(() {
        mData = data.categories;
      });
    }
  }

  List<Category> moreList = [];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1080, allowFontScaling: false);
    int childCount = mData.length > 6
        ? mData.sublist(6, mData.length).length
        : mData.sublist(0, mData.length).length;

    mData.length > 6
        ? moreList = mData.sublist(6, mData.length)
        : moreList = mData.sublist(0, mData.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('电台分类'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  child: Center(
                    child: Text(
                      '热门分类',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40, bottom: 10),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(0.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 4行
//                mainAxisSpacing: 20.0,
//                crossAxisSpacing: 10.0,
                childAspectRatio: 3.6,
              ),
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                int childCount = mData.length >= 6
                    ? mData.sublist(0, 6).length
                    : mData.sublist(0, mData.length).length;

                return Container(
//                  color: Colors.blue,

                  child: Column(
                    children: [
                      Divider(
                        height: 0.6,
                      ),
                      Expanded(
                        child: Container(
//                          color: Colors.blue,
                          child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Gaps.hGap28,
                                  Image.network(
                                    mData[index].picIPadUrl,
                                    width: 20,
                                  ),
                                  Gaps.hGap5,
                                  Text(
                                    mData[index].name,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Spacer(),
                                  Visibility(
                                    visible: index % 2 == 0 ? true : false,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      width: 0.6,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      //这里我就不考虑小于6 为单数的情况了
                      Visibility(
                        visible: index == childCount - 1 ? true : false,
                        child: Divider(
                          height: 0.6,
                        ),
                      ),
                      Visibility(
                        visible: index == childCount - 2 ? true : false,
                        child: Divider(
                          height: 0.6,
                        ),
                      ),
                    ],
                  ),
                );
              },
                  childCount: mData.length >= 6
                      ? mData.sublist(0, 6).length
                      : mData.sublist(0, mData.length).length),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  child: Center(
                    child: Text(
                      '更多分类',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40, bottom: 10),
                ),
              ],
            ),
          ),
          SliverPadding(
              padding: EdgeInsets.all(0.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 4行
//                mainAxisSpacing: 20.0,
//                crossAxisSpacing: 10.0,
                  childAspectRatio: 3.6,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
//                  color: Colors.blue,

                      child: Column(
                        children: [
                          Divider(
                            height: 0.6,
                          ),
                          Expanded(
                            child: Container(
//                          color: Colors.blue,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Gaps.hGap28,
                                      Image.network(
                                        moreList[index].picIPadUrl,
                                        width: 20,
                                      ),
                                      Gaps.hGap5,
                                      Text(
                                        moreList[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      Spacer(),
                                      Visibility(
                                        visible: index % 2 == 0 ? true : false,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          width: 0.6,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          //这里我就不考虑小于6 为单数的情况了
                          Visibility(
                            visible: index == childCount - 1 ? true : false,
                            child: Divider(
                              height: 0.6,
                            ),
                          ),
                          Visibility(
                            visible: index == childCount - 2 ? true : false,
                            child: Divider(
                              height: 0.6,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: moreList.length,
                ),
              )),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40, bottom: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
