import 'package:avalon_family/common/index.dart';
import 'package:intl/intl.dart';

/// 扩展DateTime
extension ExDateTime on DateTime {
  // 格式化DateTime
  String dateFormat(String pattern) {
    return DateFormat(pattern).format(this);
  }

  // 获取日期字符串
  String toDateString() {
    return dateFormat(DateFormats.y_mo_d);
  }

  // 获取日期时间字符串
  String toDateTimeString() {
    return dateFormat(DateFormats.full);
  }

  // 获取时间字符串
  String toTimeString() {
    return dateFormat(DateFormats.h_m_s);
  }
}
