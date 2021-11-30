class CommentList {
  late bool isMusician;
  late int userId;
  late  bool moreHot;
  late  int code;
  late  int total;
  late bool more;
  late List<Comment> comments;

  static CommentList fromJson(Map<String, dynamic> map) {
    CommentList commentList = CommentList();
    commentList.code = map['code'];
    commentList.comments = []
      ..addAll((map['comments'] as List).map((o) => Comment.fromJson(o)));
    return commentList;
  }
}

class Comment {
  late int likedCount;
  late  int time;
  late bool liked;
  late  int playCount;
  late  int commentId;
  late  String content;

  late User user;

  static Comment fromJson(Map<String, dynamic> map) {
    Comment comment = Comment();
    comment.likedCount = map['likedCount'];
    comment.time = map['time'];
    comment.liked = map['liked'];
    comment.playCount = map['playCount'];
    comment.commentId = map['commentId'];
    comment.content = map['content'];
    comment.user = User.fromJson(map['user']);
    return comment;
  }
}

class User {
 late String avatarUrl;
 late String nickname;
 late String remarkName;
 late  int vipType;
 late int userId;
 late int userType;

  static User fromJson(Map<String, dynamic> map) {
    User user = User();
    user.avatarUrl = map['avatarUrl'];
    user.nickname = map['nickname'];
    user.remarkName = map['remarkName'];
    user.vipType = map['vipType'];
    user.userId = map['userId'];
    user.userType = map['userType'];

    return user;
  }
}
