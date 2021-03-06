import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_music/data/protocol/tracks.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:flutter/material.dart';

class AudioPlayManager extends ChangeNotifier {
  StreamController<String> _curPositionController =
      StreamController<String>.broadcast();
  AudioPlayer _audioPlayer = AudioPlayer(); //播放器
  List<Tracks> _tracks = []; //播放列表
  int curIndex = 0;
  int _totalDuration = 0;

  Duration curSongDuration;

  ///通过 Stream 实现每秒钟局部更新数据

  Stream<String> get curPositionStream => _curPositionController.stream;

  int get totalDuration => _totalDuration;

  Tracks get curSong => _tracks[curIndex];

  AudioPlayerState _curState;

  AudioPlayerState get curState => _curState;

  AudioPlayManager() {
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);
    // 播放状态监听
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _curState = state;
      notifyListeners();
      print('state==${state.index}');
    });
    _audioPlayer.onDurationChanged.listen((d) {
      curSongDuration = d;
      // print(
      //   '播放时长${DateUtil.formatDateMs(d.inMilliseconds, format: "mm:ss")}',
      // );
    });
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      sinkProgress(duration.inMilliseconds > curSongDuration.inMilliseconds
          ? curSongDuration.inMilliseconds
          : duration.inMilliseconds);
    });
  }

  // 歌曲进度
  void sinkProgress(int m) {
    _curPositionController.sink.add('$m-${curSongDuration.inMilliseconds}');
  }

  // 播放一首歌
  Future<void> playSong(Tracks track) async {
    _tracks.insert(curIndex, track);
    play();
  }
  /// 跳转到固定时间
  void seekPlay(int milliseconds){
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
    resumePlay();
  }
  /// 播放
  void play() async {
    var songId = this._tracks[curIndex].id;
    Map<String, dynamic> formData = {
      'id': songId,
    };
    var url = await RequestManager.getMusicURL(formData);
    print('播放---->${this._tracks[curIndex].name}');
    print('播放---->${url}');
    _audioPlayer.play(url);
  }

  /// 暂停、恢复
  void togglePlay() {
    if (_audioPlayer.state == AudioPlayerState.PAUSED) {
      resumePlay();
    } else {
      pausePlay();
    }
  }

  // 暂停
  void pausePlay() {
    _audioPlayer.pause();
  }

  /// 恢复播放
  void resumePlay() {
    _audioPlayer.resume();
  }

  @override
  void dispose() {
    super.dispose();
    _curPositionController.close();
    _audioPlayer.dispose();
  }
}
