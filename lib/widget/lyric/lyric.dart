class Lyric {
  String lyric;
  Duration startTime;
  Duration endTime;
  bool isRemark;
  double offset;
  Lyric(this.lyric, {required this.startTime, required this.endTime, this.isRemark = false,this.offset=0});

  @override
  String toString() {
    return 'Lyric{lyric: $lyric, startTime: $startTime, endTime: $endTime}';
  }
}