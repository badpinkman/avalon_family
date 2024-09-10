import 'dart:io';

import 'package:avalon_family/common/index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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

    var platform = Platform.operatingSystem;
    String path = '${supportDirectory.path}\\$_dbName';
    path = await getDatabasesPath();
    _db = await openDatabase(_dbName);
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
