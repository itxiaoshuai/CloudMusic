import 'package:common_utils/common_utils.dart';

class NumberUtils {
  static const double MILLION = 10000.0;
  static const double MILLIONS = 1000000.0;
  static const double BILLION = 100000000.0;
  static const String MILLION_UNIT = "万";
  static const String BILLION_UNIT = "亿";

  static String amountConversion(num amount) {
    //最终返回的结果值
    String result = amount.toString();

    if (amount > MILLION * 10 && amount <= MILLIONS) {
      result = '${(amount / MILLION).toStringAsFixed(1)}$MILLION_UNIT';
    } else if (amount > MILLIONS && amount <= BILLION) {
      //如果值刚好是10000万，则要变成1亿
      if (amount == BILLION) {
        result = '${amount ~/ BILLION}$BILLION_UNIT';
      } else {
        // result = '${amount ~/ MILLION}$MILLION_UNIT';
        result = (NumUtil.getNumByValueDouble(amount / MILLION, 1))!
                .toStringAsFixed(1) +
            MILLION_UNIT;
      }
    }

    //金额大于1亿
    else if (amount > BILLION) {
      // result = '${amount / BILLION}$BILLION_UNIT';
      result = (NumUtil.getNumByValueDouble(amount / BILLION, 1))!
              .toStringAsFixed(1) +
          BILLION_UNIT;
    } else {
      result = amount.toString();
    }
    return result;
  }

  static String formatNum(num n) {
    if (n >= MILLION) {
      var r = n ~/ MILLION;
      return '${r >= 10 ? 10 : r}w+';
    } else {
      return '$n';
    }
  }

  static String amountCapacity(num amount) {
    StringBuffer timeStr = StringBuffer();
    // if (amount <= 0) {
    //   timeStr.write('0B');
    // } else if (amount <= 1024) {
    //   timeStr.write(amount/1024);
    //   timeStr.write('K');
    // } else if (amount <= 1024 * 1024 ) {
    //   timeStr.write(amount/1024/1024);
    //   timeStr.write('M');
    // }  else {
    //   timeStr.write(amount/1024/1024/1024);
    //   timeStr.write('G');
    // }
    double c = amount / 1024 / 1024 / 1024;
    timeStr.write(format(c, 2));
    timeStr.write('G');
    return timeStr.toString();
  }

  static String format(double num, int location) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        location) {
      //小数点后有几位小数
      return num.toStringAsFixed(location)
          .substring(0, num.toString().lastIndexOf(".") + location + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + location + 1)
          .toString();
    }
  }
}
