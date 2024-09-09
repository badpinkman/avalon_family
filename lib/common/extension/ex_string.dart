/**
 * @author: Kxmrg
 * @github: https://github.com/Kxmrg
 * @version: 1.0.0
 * @copyright: Copyright © 2023-2024 Kxmrg
 * @license: MIT License
 * @date: 2024-06-28
 * @description:
 */

import 'package:avalon_family/common/index.dart';

/// 扩展String
extension ExString on String? {
  /// 是否为空或null
  bool get isEmptyOrNull => _isEmptyOrNull();

  /// 是否不为空或null
  bool get isNotEmptyOrNull => !_isEmptyOrNull();

  bool _isEmptyOrNull() {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  /// 格式化时间字符串
  String? dateFormat(String pattern) {
    if (this == null) {
      return null;
    }
    var date = DateTime.parse(this!);
    return date.dateFormat(pattern);
  }

  /// 格式化时间字符串为日期
  String? toDateString() {
    return dateFormat(DateFormats.y_mo_d);
  }

  /// 格式化时间字符串为日期时间
  String? toDateTimeString() {
    return dateFormat(DateFormats.full);
  }

  /// 格式化时间字符串为时间
  String? toTimeString() {
    return dateFormat(DateFormats.h_m_s);
  }

  /// 获取DateTime对象
  DateTime? getDateTime({bool? isUtc}) {
    if (this == null) {
      return null;
    }
    DateTime? dateTime = DateTime.tryParse(this!);
    if (isUtc != null) {
      if (isUtc) {
        dateTime = dateTime?.toUtc();
      } else {
        dateTime = dateTime?.toLocal();
      }
    }
    return dateTime;
  }

  /// MD5加密
  String? md5() {
    if (this == null) {
      return null;
    }
    return EncryptUtil.encodeMd5(this!);
  }

  /// Base64编码
  String? encodeBase64() {
    if (this == null) {
      return null;
    }
    return EncryptUtil.encodeBase64(this!);
  }

  /// Base64解码
  String? decodeBase64() {
    if (this == null) {
      return null;
    }
    return EncryptUtil.decodeBase64(this!);
  }

  /// 转为int类型
  int? toInt({int defValue = 0}) {
    if (this == null) {
      return null;
    }
    return int.tryParse(this!) ?? defValue;
  }

  /// 转为double类型
  double? toDouble({double defValue = 0}) {
    if (this == null) {
      return null;
    }
    return double.tryParse(this!) ?? defValue;
  }

  /// 转为num类型
  num? toNumber({num defValue = 0}) {
    if (this == null) {
      return null;
    }
    return num.tryParse(this!) ?? defValue;
  }
}
