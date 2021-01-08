import 'package:flutter/material.dart';

import '../../../r.dart';

class MessageCommentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageCommentPageState();
}

class _MessageCommentPageState extends State<MessageCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //修改颜色
        ),
        backgroundColor: Colors.white,
        title: Text('评论',style: R.style.textDark16,),
      ),
    );
  }
}
