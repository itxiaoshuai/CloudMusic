import 'package:flutter/material.dart';
import 'package:flutter_app/widget/widget_img_menu.dart';
import '../r.dart';

class PlayBottomMenuWidget extends StatelessWidget {
  // final PlaySongsModel model;
  //
  // PlayBottomMenuWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          
          ImageTapWidget('images/icon_song_play_type_1.png','images/icon_song_play_type_1.png', 40),
          ImageTapWidget(
            'images/icon_play_mode_single_cycle_normal.png',
            'images/icon_play_mode_single_cycle_select.png',
            40,
            onTap: () {
              print('上一曲');
            },
          ),
          ImageTapWidget(
            'images/icon_song_left_normal.png',
            'images/icon_song_left_select.png',
            40,
            onTap: () {
              print('上一曲');
            },
          ),
          ImageTapWidget(
            R.mipmap.play,
            R.mipmap.playSelect,
            75,
            onTap: () {},
          ),
          ImageTapWidget(
            'images/icon_song_right_normal.png',
            'images/icon_song_right_select.png',
            40,
            onTap: () {
              print('上一曲');
            },
          ),
          // ImageTapWidget(
          //
          //   'images/icon_song_play_normal.png','images/icon_song_play_touch.png',
          //   75,
          //   // onTap: () {
          //   //   // model.togglePlay();
          //   //   print('播放');
          //   //   // AudioPlayer audioPlayer = AudioPlayer();
          //   //   // audioPlayer.play(
          //   //   //     'http://antiserver.kuwo.cn/anti.s?useless=/resource/&format=mp3&rid=MUSIC_8396778&response=res&type=convert_url&');
          //   //   // play() async {
          //   //   //   int result = await audioPlayer.play(xxx.mp3);
          //   //   //   if (result == 1) {
          //   //   //     // success
          //   //   //     print('play success');
          //   //   //   } else {
          //   //   //     print('play failed');
          //   //   //   }
          //   //   // }
          //   // },
          // ),

          ImageTapWidget('images/icon_play_songs_normal.png','images/icon_play_songs_select.png', 40),
        ],
      ),
    );
  }
}
enum AudioPlayerMode {
  LIST_CYCLE,
  RANDOM_PLAY ,
  SINGLE_CYCLE,
}

