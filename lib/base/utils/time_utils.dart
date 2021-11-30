import 'package:common_utils/common_utils.dart';

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

  static String getAgeGroup(int agoTime) {
    StringBuffer timeStr = StringBuffer();
    String ageGroup = DateUtil.formatDateMs(agoTime, format: 'yyyy');
    if (int.parse(ageGroup) >= 1970 && int.parse(ageGroup) <= 1980) {
      timeStr.write('70后');
      return timeStr.toString();
    }
    if (int.parse(ageGroup) >= 1980 && int.parse(ageGroup) <= 1990) {
      timeStr.write('80后');
      return timeStr.toString();
    }
    if (int.parse(ageGroup) >= 1990 && int.parse(ageGroup) <= 2000) {
      timeStr.write('90后');
      return timeStr.toString();
    }
    if (int.parse(ageGroup) >= 2000) {
      timeStr.write('00后');
      return timeStr.toString();
    }
    return timeStr.toString();
  }

  static String getconstellation(int agoTime) {
    String monthS = DateUtil.formatDateMs(agoTime, format: 'MM');
    String dayS = DateUtil.formatDateMs(agoTime, format: 'dd');
    int month = int.parse(monthS);
    int day = int.parse(dayS);
    var constellations = [
      "魔蝎座",
      "水瓶座",
      "双鱼座",
      "白羊座",
      "金牛座",
      "双子座",
      "巨蟹座",
      "狮子座",
      "处女座",
      "天秤座",
      "天蝎座",
      "射手座"
    ];
    var divide = [19, 18, 20, 19, 20, 21, 22, 22, 22, 23, 22, 21];

    if (day <= divide[(month - 1)]) {
      return constellations[(month - 1)];
    }
    if (month >= 12) {
      month = 0;
    }
    return constellations[month];
  }
}
