import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/find/PageFind.dart';
import 'package:flutter_app/pages/find/widget/SpinKitWave.dart';
import 'package:flutter_app/pages/my/PageMy.dart';
import 'package:flutter_app/widget/HomeDrawer.dart';

import 'package:flutter/animation.dart';
import 'package:flutter_app/widget/loading/bar.dart';

import 'dart:ui' show lerpDouble;

import 'package:flutter_app/widget/loading/color_palette.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final random =  Random();
  AnimationController animation;
  BarChartTween tween;

  @override
  void initState() {
    super.initState();
    animation =  AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    )
    ..repeat();
    tween =  BarChartTween( BarChart.empty(),  BarChart.random(random));
    animation.forward();
    animation.addStatusListener((status){
      if(status==AnimationStatus.completed){
//        tween =  BarChartTween(
//          tween.evaluate(animation),
//          BarChart.random(random),
//        );
        animation.reverse();
      }

    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      tween =  BarChartTween(
        tween.evaluate(animation),
         BarChart.random(random),
      );
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(
          child:  CustomPaint(
              size:  Size(200.0, 100.0),
              painter:  BarChartPainter(tween.animate(animation))
          )
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: changeData,
        child:  Icon(Icons.refresh),
      ),
    );
  }
}





class Bar {
  Bar(this.height, this.color);
  final double height;
  final Color color;

  factory Bar.empty() =>  Bar(0.0, Colors.transparent);
  factory Bar.random(Random random) {
    return  Bar(
        random.nextDouble() * 100.0,
        ColorPalette.primary.random(random)
    );
  }

  static Bar lerp(Bar begin, Bar end, double t) {
    return  Bar(
        lerpDouble(begin.height, end.height, t),
        Color.lerp(begin.color, end.color, t)
    );
  }
}

class BarTween extends Tween<Bar> {
  BarTween(Bar begin, Bar end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) => Bar.lerp(begin, end, t);
}











//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.red,
//      ),
//      home: HomePage(),
//    );
//  }
//}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController =  TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
//        title: TabContainerState(),
        title: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          tabs: <Widget>[
             Tab(
              text: '我的',
            ),
             Tab(
              text: '发现',
            ),
             Tab(
              text: '朋友',
            ),
             Tab(
              text: '视频',
            ),
          ],
          controller: _tabController,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      body:  TabBarView(
        controller: _tabController,
        children: <Widget>[
          MyPage(),
          FindPage(),
          Center(child: Text('朋友')),
          Center(child: Text('视频')),
        ],
      ),
      drawer: HomeDrawer(),
    );
  }
}

class TabContainerState extends StatefulWidget {
  @override
  _TabContainerState createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainerState>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _tabControllerIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: choices.length,
      vsync: this,
    );
    _tabController.index = _tabControllerIndex;
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _tabControllerIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: choices.length,
        initialIndex: _tabControllerIndex,
        child: TabBar(
          //创建TabBar实例
          isScrollable: true,
          //这个属性是导航栏是否支持滚动，false则会挤在一起了
          unselectedLabelColor: Colors.grey,
          //未选标签标签的颜色(这里定义为灰色)
          labelColor: Colors.black,
//          选中的颜色（黑色）
          indicatorColor: Colors.red,
          //指示器颜色
          indicatorWeight: 2,
          controller: _tabController,

          tabs: choices.map((Choice choice) {
            //选项卡
            return  Tab(
              text: choice.title,
            );
          }).toList(),

          // isScrollable: true,
          // labelPadding: EdgeInsets.only(left: 5, right: 5),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.categoryId});

  final String title; //这个参数是分类名称
  final int categoryId; //这个适用于网络请求的参数，获取不同分类列表
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: '我的',
    categoryId: 1,
  ),
  const Choice(
    title: '发现',
    categoryId: 2,
  ),
  const Choice(
    title: '朋友',
    categoryId: 3,
  ),
  const Choice(
    title: '视频',
    categoryId: 4,
  ),
];

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
