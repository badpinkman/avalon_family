import 'dart:io';

import 'package:avalon_family/common/index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBManager {
  /// 多实例
  static final Map<String, DBManager> _storageMap = {};

  /// 数据库名称
  final String _dbName;

  /// 数据库实例
  late Database _db;

  Database get db => _db;

  static Future<DBManager> instance({required String dbName}) async {
    if (!dbName.endsWith('.db')) {
      dbName = '$dbName.db';
    }
    var storage = _storageMap[dbName];
    storage ??= await DBManager._(dbName: dbName)._init();
    return storage;
  }

  /// 多实例模式, 一个数据库一个实例
  DBManager._({required String dbName}) : _dbName = dbName {
    _storageMap[_dbName] = this;
  }

  Future<DBManager> _init() async {
    final supportDirectory = await getApplicationSupportDirectory();
    String platform = Platform.operatingSystem;
    String path = '${supportDirectory.path}\\$_dbName';
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      _db = await databaseFactoryFfi.openDatabase(_dbName);
    }

    ///else if (Platform.isLinux && false) {
    /// 不进入该判断 Linux与Windows共用同一个方法
    /// TODO Linux @See https://pub.dev/packages/sqflite_common_ffi
    /// 通过var platform = Platform.operatingSystem; 查询当前操作系统
    /// 需要测试上方Windows的判断, 通过查看源码注释, 显示已经支持Linux
    /// Logger.log('当前操作系统: [$platform] 暂时不支持数据库操作');
    /// throw Exception('当前操作系统: [$platform] 暂时不支持数据库操作');
    ///}
    else {
      path = await getDatabasesPath();
      _db = await openDatabase(_dbName);
    }
    Logger.d(
        '当前操作系统: [$platform] 数据库初始化完毕: db var ${await _db.getVersion()} path = $path');
    return this;
  }

  /// 销毁数据库
  void destroy() {
    _db.close();
    _storageMap.remove(_dbName);
  }
}
