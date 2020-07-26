import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/protocol/RadioCategoryData.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1080, allowFontScaling: false);
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
                  color: Colors.cyan,
                  child: Center(
                    child: Text(
                      '热门分类',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 4行
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 5.0,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: Text(
                    mData[index].name,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }, childCount: mData.length),
            ),
          ),
        ],
      ),
    );
  }
}
