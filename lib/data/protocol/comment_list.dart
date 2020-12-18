class CommentList {
  bool isMusician;
  int userId;
  bool moreHot;
  int code;
  int total;
  bool more;
  List<Comment> comments;

  static CommentList fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    CommentList commentList = CommentList();
    commentList.code = map['code'];
    commentList.comments = List()
      ..addAll((map['comments'] as List ?? []).map((o) => Comment.fromJson(o)));
    return commentList;
  }
}

class Comment {
  int likedCount;
  int time;
  bool liked;
  int playCount;
  int commentId;
  String content;

  User user;

  static Comment fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
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
  String avatarUrl;
  String nickname;
  String remarkName;
  int vipType;
  int userId;
  int userType;

  static User fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
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
