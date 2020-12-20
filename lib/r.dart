class MipMap {
  const MipMap() : super();

  String get dailySpecial => 'images/t_dragonball_icn_daily.png'; //每日推荐
  String get fm => 'images/t_dragonball_icn_fm.png'; //私人FM
  String get playlist => 'images/t_dragonball_icn_playlist.png'; //歌单
  String get rankingList => 'images/t_dragonball_icn_rank.png'; //排行榜
  String get liveStreaming => 'images/t_dragonball_icn_look.png'; //直播
  String get digitalAlbum => 'images/t_dragonball_icn_digitalalbum.png'; //数字专辑
  String get play => 'images/icon_song_play_normal.png'; //播放
  String get playSelect => 'images/icon_song_play_touch.png'; //播放
}

class MipMapText {
  const MipMapText() : super();

  String get dailySpecial => '每日推荐';

  String get fm => '私人FM';

  String get playlist => '歌单';

  String get rankingList => '排行榜';

  String get liveStreaming => '直播';

  String get digitalAlbum => '数字专辑';
}

class R {
  static const MipMap mipmap = MipMap();
  static const MipMapText string = MipMapText();
}
