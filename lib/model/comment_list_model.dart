

import 'package:cloud_music/data/protocol/comment_list.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';

class CommentListModel extends LayoutStateModel {
  late CommentList _commentList;

  CommentList get data => _commentList;
  loadData(Map<String, dynamic> queryParameters) {
    setState(LayoutState.LOADING);
    RequestManager.fetchCommentList(queryParameters)
        .then((value) => handelData(value));
  }

  void handelData(value) {
    print(value);
    _commentList = CommentList.fromJson(value);
    print(_commentList.comments.length);
    setState(LayoutState.SUCCESS);
  }
}
