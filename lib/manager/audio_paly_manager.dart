import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_music/data/protocol/tracks.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:flutter/material.dart';

class AudioPlayManager extends ChangeNotifier {
  StreamController<String> _curPositionController =
      StreamController<String>.broadcast();
  AudioPlayer _audioPlayer = AudioPlayer(); //播放器
  late List<Tracks> _tracks = []; //播放列表
  late int curIndex = 0;
  late int _totalDuration = 0;

  late Duration curSongDuration;

  ///通过 Stream 实现每秒钟局部更新数据

  Stream<String> get curPositionStream => _curPositionController.stream;

  int get totalDuration => _totalDuration;

  Tracks get curSong => _tracks[curIndex];

  PlayerState _curState = PlayerState.stopped;

  PlayerState get curState => _curState;

  AudioPlayManager() {
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
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
    _audioPlayer.onPositionChanged.listen((Duration duration) {
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

  Future<void> playSongByIndex(int index) async {
    if (_tracks.length > index) {
      curIndex = index;
      play();
    }
  }

  // 添加歌曲
  void addSongs(List<Tracks> songs) {
    this._tracks.clear();
    this._tracks.addAll(songs);
  }

  /// 跳转到固定时间
  void seekPlay(int milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
    resumePlay();
  }

  /// 播放
  void play() async {
    debugPrint("当前播放列表个数${_tracks.length}");
    debugPrint("当前播放位置${curIndex}");
    var songId = this._tracks[curIndex].id;
    Map<String, dynamic> formData = {
      'id': songId,
    };
    var url = await RequestManager.getMusicURL(formData);
    // print('播放---->${this._tracks[curIndex].name}');
    print('播放---->$url');
    _audioPlayer.setSourceUrl(url);
    _audioPlayer.play(UrlSource(url));
  }

  /// 暂停、恢复
  void togglePlay() {
    if (_audioPlayer.state == PlayerState.paused) {
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

  void prePlay() {
    print('上一曲');
    if (curIndex <= 0) {
      curIndex = _tracks.length - 1;
    } else {
      curIndex--;
    }
    play();
    notifyListeners();
  }

  /// 下一首
  void nextPlay() {
    print('下一曲');
    if (curIndex >= _tracks.length) {
      curIndex = 0;
    } else {
      curIndex++;
    }
    play();
  }

  @override
  void dispose() {
    super.dispose();
    _curPositionController.close();
    _audioPlayer.dispose();
  }
}
