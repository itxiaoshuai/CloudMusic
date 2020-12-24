

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_music/manager/audio_paly_manager.dart';
import 'package:cloud_music/widget/widget_img_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            setState(() {});
          },
        );
      case AudioPlayerMode.RANDOM_PLAY: //随机播放
        return ImageTapWidget(
          R.mipmap.randomPlayNormal,
          R.mipmap.randomPlaySelect,
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
            setState(() {});
          },
        );

      case AudioPlayerMode.SINGLE_CYCLE: //单曲循环
        return ImageTapWidget(
          R.mipmap.singleCycleNormal,
          R.mipmap.singleCycleSelect,
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
            setState(() {});
          },
        );
    }
    return ImageTapWidget(
      R.mipmap.listCycleNormal,
      R.mipmap.listCycleSelect,
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
        setState(() {});
      },
    );
  }

  Widget _buildPlayStateWidget(AudioPlayManager manager) {
    if (manager.curState == AudioPlayerState.PAUSED) {
      return ImageTapWidget(
        R.mipmap.play,
        R.mipmap.playSelect,
        75,
        onTap: () {},
      );
    } else {
      return ImageTapWidget(
        R.mipmap.pauseNormal,
        R.mipmap.pauseSelect,
        75,
        onTap: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayManager>(builder: (context, model, child) {
      return Container(
        // color: Colors.yellow,
        alignment: Alignment.topCenter,
        child: Row(
          children: <Widget>[
            _buildPlayModeWidget(),
            ImageTapWidget(
              R.mipmap.prevNormal,
              R.mipmap.prevSelect,
              40,
              onTap: () {
                print('上一曲');
              },
            ),
            _buildPlayStateWidget(model),
            // ImageTapWidget(
            //   R.mipmap.play,
            //   R.mipmap.playSelect,
            //   75,
            //   onTap: () {},
            // ),
            ImageTapWidget(
              R.mipmap.nextNormal,
              R.mipmap.nextSelect,
              40,
              onTap: () {
                print('上一曲');
              },
            ),
            ImageTapWidget(
              R.mipmap.songsNormal,
              R.mipmap.songsSelect,
              40,
              onTap: () {},
            ),
          ],
        ),
      );
    });
  }
}

enum AudioPlayerMode {
  LIST_CYCLE,
  RANDOM_PLAY,
  SINGLE_CYCLE,
}
