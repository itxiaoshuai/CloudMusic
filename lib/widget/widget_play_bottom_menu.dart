import 'package:flutter/material.dart';
import 'package:flutter_app/widget/widget_img_menu.dart';
import '../r.dart';

class PlayBottomMenuWidget extends StatefulWidget {
  @override
  _PlayBottomMenuWidgetState createState() => _PlayBottomMenuWidgetState();
}

class _PlayBottomMenuWidgetState extends State<PlayBottomMenuWidget> {
  AudioPlayerMode _audioPlayerMode;

  Widget _buildPlayModeWidget() {
    switch (_audioPlayerMode) {
      case AudioPlayerMode.LIST_CYCLE: //列表循环
        return ImageTapWidget(
          'images/icon_list_cycle_normal.png',
          'images/icon_list_cycle_select.png',
          40,
          onTap: () {
            switch (_audioPlayerMode) {
              case AudioPlayerMode.LIST_CYCLE: //列表循环
                _audioPlayerMode = AudioPlayerMode.RANDOM_PLAY;
                break;
              case AudioPlayerMode.RANDOM_PLAY: //随机播放
                _audioPlayerMode = AudioPlayerMode.SINGLE_CYCLE;
                break;
              case AudioPlayerMode.SINGLE_CYCLE: //单曲循环
                _audioPlayerMode = AudioPlayerMode.LIST_CYCLE;
                break;
              default:
                _audioPlayerMode = AudioPlayerMode.RANDOM_PLAY;
            }
            setState(() {

            });
          },
        );
      case AudioPlayerMode.RANDOM_PLAY: //随机播放
        return ImageTapWidget(
          'images/icon_random_play_normal.png',
          'images/icon_random_play_select.png',
          40,
          onTap: () {
            switch (_audioPlayerMode) {
              case AudioPlayerMode.LIST_CYCLE: //列表循环
                _audioPlayerMode = AudioPlayerMode.RANDOM_PLAY;
                break;
              case AudioPlayerMode.RANDOM_PLAY: //随机播放
                _audioPlayerMode = AudioPlayerMode.SINGLE_CYCLE;
                break;
              case AudioPlayerMode.SINGLE_CYCLE: //单曲循环
                _audioPlayerMode = AudioPlayerMode.LIST_CYCLE;
                break;
              default:
                _audioPlayerMode = AudioPlayerMode.RANDOM_PLAY;
            }
            setState(() {

            });
          },
        );

      case AudioPlayerMode.SINGLE_CYCLE: //单曲循环
        return ImageTapWidget(
          'images/icon_single_cycle_normal.png',
          'images/icon_single_cycle_select.png',
          40,
          onTap: () {
            switch (_audioPlayerMode) {
              case AudioPlayerMode.LIST_CYCLE: //列表循环
                _audioPlayerMode = AudioPlayerMode.RANDOM_PLAY;
                break;
              case AudioPlayerMode.RANDOM_PLAY: //随机播放
                _audioPlayerMode = AudioPlayerMode.SINGLE_CYCLE;
                break;
              case AudioPlayerMode.SINGLE_CYCLE: //单曲循环
                _audioPlayerMode = AudioPlayerMode.LIST_CYCLE;
                break;
              default:
                _audioPlayerMode = AudioPlayerMode.RANDOM_PLAY;
            }
            setState(() {

            });
          },
        );
    }
    return ImageTapWidget(
      'images/icon_list_cycle_normal.png',
      'images/icon_list_cycle_select.png',
      40,
      onTap: () {
        switch (_audioPlayerMode) {
          case AudioPlayerMode.LIST_CYCLE: //列表循环
            _audioPlayerMode = AudioPlayerMode.RANDOM_PLAY;
            break;
          case AudioPlayerMode.RANDOM_PLAY: //随机播放
            _audioPlayerMode = AudioPlayerMode.SINGLE_CYCLE;
            break;
          case AudioPlayerMode.SINGLE_CYCLE: //单曲循环
            _audioPlayerMode = AudioPlayerMode.LIST_CYCLE;
            break;
          default:
            _audioPlayerMode = AudioPlayerMode.RANDOM_PLAY;
        }
        setState(() {

        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          _buildPlayModeWidget(),

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

          ImageTapWidget('images/icon_play_songs_normal.png',
              'images/icon_play_songs_select.png', 40),
        ],
      ),
    );
  }
}

enum AudioPlayerMode {
  LIST_CYCLE,
  RANDOM_PLAY,
  SINGLE_CYCLE,
}
