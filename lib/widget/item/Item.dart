import 'package:flutter/material.dart';

class ShopPageFragment extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ShopFragment();
  }

}
class _ShopFragment extends State<ShopPageFragment>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        _shopTilte("精品推荐"),
        new Flexible(
          flex: 1,
          child: _List(),
        )
      ],
    );
  }
  //第一种
  _List(){
    return new GridView.count(crossAxisCount: 3,
      primary: false,
      children: _getGrid(),
      shrinkWrap: true,
    );
  }
  //第二种
  _Gird1(){
    return new GridView.custom(gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,

    ),
      childrenDelegate: new SliverChildBuilderDelegate(
            (context,index){
          return new Image.asset("images/homes.jpg");
        },
        childCount: 30,
      ),
      shrinkWrap: true,
    );
  }
  //第三种
  _GirdExtent(){
    return new SliverGrid.extent(maxCrossAxisExtent: 1080.0,
      mainAxisSpacing: 8.0,
      children: _getGrid(),
    );
  }

  //第四种
  _GridScoll(){
    return new CustomScrollView(
      primary: false,
      slivers: <Widget>[
        new SliverPadding(padding: const EdgeInsets.all(8.0),
          sliver: new SliverGrid.count(crossAxisCount: 3,
            children: _getGrid(),
          ),
        ),
      ],
      shrinkWrap: true,
    );
  }

  List<Widget> _getGrid(){
    List<Widget> gridList = new List();
    //gridList.add(_shopTilte("精品推荐"));
    for(int i =0;i<6;i++){
      gridList.add(_viewGird());
    }
    return gridList;
  }

  Widget _shopTilte(String title){
    return
      new Row(
        children: <Widget>[

          new Container(
            margin: new EdgeInsets.only(
              left: 10.0,
            ),
            color: Colors.green,
            width: 5.0,
            height: 30.0,

          ),

          new Container(
            margin: const EdgeInsets.only(
              left: 10.0,
            ),
          ),

          new Text(title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,

            ),
          ),

        ],
      );
  }


  Widget _viewGird(){
    return new Column(

      children: <Widget>[
        //图片
        new Image.asset("images/main_discount.png",
          width: 60.0,
          height: 60.0,
        ),
        //名字
        new Text("轮胎",
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        //价格
        new Text("￥1500.0",
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.amberAccent,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
