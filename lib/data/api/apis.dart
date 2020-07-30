class MusicApi {
  /// 发现页(排行榜) http://localhost:3000/toplist
  static const String TOPLIST = "/toplist";

  ///http://localhost:3000/playlist/detail?id=19723756(歌单详情)
  static const String SONGLISTDETAILS = "/playlist/detail";

  ///http://localhost:3000/personalized(推荐歌单)
  static const String SONGLISTDRECOMMEND = "/personalized";

  static const String NewSong = "/personalized/newsong";

  static const String NewAlbum = "/album/newest";

  ///调用例子 : /login/cellphone?phone=xxx&password=yyy
  static const String LOGIN = "/login/cellphone";
}
