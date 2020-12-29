import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {

  int limit;
  int offset;

  @override
  void initState() {
    limit = 10;
    offset = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold();
      return super.build(context);
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
