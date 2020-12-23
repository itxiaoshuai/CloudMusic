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

  String get nextNormal => 'images/icon_song_right_normal.png'; //下一曲
  String get nextSelect => 'images/icon_song_right_select.png'; //下一曲

  String get songsNormal => 'images/icon_play_songs_normal.png'; //歌曲列表
  String get songsSelect => 'images/icon_play_songs_select.png';

  String get prevNormal => 'images/icon_song_left_normal.png'; //上一曲
  String get prevSelect => 'images/icon_song_left_select.png';


  String get randomPlayNormal => 'images/icon_random_play_normal.png'; //随机播放
  String get randomPlaySelect => 'images/icon_random_play_select.png';


  String get singleCycleNormal => 'images/icon_single_cycle_normal.png'; //单曲循环
  String get singleCycleSelect => 'images/icon_single_cycle_select.png';


  String get listCycleNormal => 'images/icon_list_cycle_normal.png'; //列表循环
  String get listCycleSelect => 'images/icon_list_cycle_select.png';

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
