import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/api/apis.dart';
import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';

class FutureBuilderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FutureBuilderState();
}

class FutureBuilderState extends State<FutureBuilderPage> {
  String title = 'FutureBuilder使用';

  Future _gerData() async {
    var response = await Http().get(MusicApi.SONGLISTDRECOMMEND);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            title = title + '.';
          });
        },
        child: Icon(Icons.title),
      ),
      body: FutureBuilder(
        builder: _buildFuture,
        future: _gerData(), // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
      ),
    );
  }

  ///snapshot就是_calculation在时间轴上执行过程的状态快照
  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createListView(context, snapshot);
      default:
        return null;
    }
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    List songlist = snapshot.data['result'];
//    return ListView.builder(
//      itemBuilder: (context, index) => _itemBuilder(context, index, songlist),
//      itemCount: songlist.length * 2,
//    );
//    _buildRecommend(context, songlist);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: songlist.length,
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
              crossAxisCount: 3,
              //子组件宽高长度比例
              childAspectRatio: 1.0),
          itemBuilder: (BuildContext context, int index) {
            //Widget Function(BuildContext context, int index)
            return ListItemCustom(img: songlist[index]['picUrl'],);
          }),
    );
  }

  Widget _itemBuilder(BuildContext context, int index, movies) {
    if (index.isOdd) {
      return Divider();
    }
    index = index ~/ 2;
    return ListTile(
      title: Text(movies[index]['name']),
    );
  }
}

Widget _buildRecommend(BuildContext context, List songlist) {
  Widget widget;
  widget = Container(
    child: SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //Grid按两列显示
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            //创建子widget
            return Container(
              child: Text('xxxx'),
//            child: ListItemCustom(
//              img: songlist[index]['picUrl'],
//            ),
            );
          },
          childCount: songlist.length,
        ),
      ),
    );,
  )
  return widget;
}
