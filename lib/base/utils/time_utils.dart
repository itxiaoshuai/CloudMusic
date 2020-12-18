class TimeUtils {
  static String getListAgoTime(num agoTime) {
    StringBuffer timeStr = StringBuffer();
    if (agoTime <= 0) {
    } else if (agoTime < 5 * 1000 * 60) {
      timeStr.write("刚刚");
    } else if (agoTime < 60 * 1000 * 60) {
      num minute = (agoTime / (1000 * 60));
      timeStr.write(minute);
      timeStr.write('分钟前');
    } else if (agoTime < 24 * 60 * 60 * 1000) {
      num hour = (agoTime / (60 * 60 * 1000));
      timeStr.write(hour);
      timeStr.write('小时前');
    } else {}
    return timeStr.toString();
  }
}
