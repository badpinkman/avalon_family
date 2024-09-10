import 'package:avalon_family/common/index.dart';
import 'package:sqflite/sqflite.dart';

/// 机器日志相关操作接口
abstract class INano3MachineList {
  // 保存 返回id
  Future<int?> saveNano3MachineReturnId(Nano3MachineModel model);
  // 仅保存
  Future<int?> saveNano3Machine(Nano3MachineModel model);

  Future<void> saveBatchNano3Machine(List<Nano3MachineModel> list);

  // 删除
  Future<int?> delNano3Machine(Nano3MachineModel model);

  // 清空表
  Future<void> cleanNano3Machine();

  // 分页查询, pageIndex: 页码, pageSize: 每页显示的数量
  Future<List<Nano3MachineModel>> getNano3MachineList(
      {int pageIndex = 1, int pageSize = 20});

  Future<int> selectCount();
  // 通过id查询数据
  Future<Nano3MachineModel> selectById(int logId);
}

class Nano3MachineDao implements INano3MachineList, ITable {
  final DBManager storage;

  Nano3MachineDao({required this.storage}) {
    storage.db.execute(
        'create table if not exists $tableName (id integer primary key autoincrement, ip text, dna text, gateway text );');
    // 创建唯一索引 DNA ，以便能够使用DNA作为唯一键来更新数据
    storage.db.execute(
        'create unique index if not exists ${tableName}_dna_idx on $tableName (dna);'
        'create index if not exists ${tableName}_ip_idx on $tableName (ip);');
  }

  @override
  String tableName = 'tb_nano3_machine';

  /// 返回删除的数量
  @override
  Future<int?> delNano3Machine(Nano3MachineModel model) async {
    int delCount = 0;
    if (model.id == null) {
      delCount =
          await storage.db.delete(tableName, where: 'dna = ${model.dna}');
    } else {
      delCount = await storage.db.delete(tableName, where: 'id = ${model.id}');
    }
    Logger.d('删除 MachineLog 成功 id = ${model.id}');
    return delCount;
  }

  @override
  Future<List<Nano3MachineModel>> getNano3MachineList({
    int pageIndex = 1,
    int pageSize = 20,
  }) async {
    var offset = (pageIndex - 1) * pageSize;
    StringBuffer where = StringBuffer();
    String sql =
        'select * from $tableName $where order by id asc limit $pageSize offset $offset';
    Logger.d('要查询的SQL: $sql');
    var results = await storage.db.rawQuery(sql);

    /// 将查询出来的结果转换成Dart Model 以方便使用
    List<Nano3MachineModel> list = results
        .map((machineLog) => Nano3MachineModel.fromJson(machineLog))
        .toList();
    return list;
  }

  @override
  Future<int?> saveNano3Machine(Nano3MachineModel model) async {
    int count = await storage.db.insert(tableName, model.toJson(),
        // 如果主键冲突, 则替换
        conflictAlgorithm: ConflictAlgorithm.replace);
    return count;
  }

  @override
  Future<int?> saveNano3MachineReturnId(Nano3MachineModel model) async {
    await storage.db.insert(tableName, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    var result = await storage.db.query(tableName, where: 'dna = ${model.dna}');
    var resultModel = Nano3MachineModel.fromJson(result.first);
    Logger.d('保存MachineLogModel 成功 id = ${resultModel.id}');
    // 解决数据 没有id的问题
    if (resultModel.id != null) {
      model.id = resultModel.id;
    }
    return resultModel.id;
  }

  @override
  Future<int> selectCount() async {
    var result =
        await storage.db.query(tableName, columns: ['COUNT(1) as count']);
    return result.first['count'] as int;
  }

  @override
  Future<void> saveBatchNano3Machine(List<Nano3MachineModel> list) async {
    // 分片入库, 每次数量100(如果不足100 就使用list的最大数据)

    Logger.d('准备保存$tableName, 数量: [${list.length}], 开始计时 ... ');
    int startTime = DateTime.now().millisecondsSinceEpoch;

    /// 批量入库数量
    int batchSize = 100;
    // 批量入库
    for (int i = 0; i < list.length; i += batchSize) {
      List<Nano3MachineModel> batch = list.sublist(
          i, i + batchSize > list.length ? list.length : i + batchSize);

      await storage.db.transaction((txn) async {
        var batchInsert = txn.batch();
        for (var model in batch) {
          batchInsert.insert(tableName, model.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
        await batchInsert.commit();
        // Logger.log('插入[${batch.length}]条数据 ... ');
      });
    }
    Logger.d(
        '保存数据完毕, 数量: [${list.length}], 共计耗时: [${DateTime.now().millisecondsSinceEpoch - startTime}]ms ');
  }

  @override
  Future<void> cleanNano3Machine() async {
    await storage.db.delete(tableName);
  }

  @override
  Future<Nano3MachineModel> selectById(int logId) async {
    String sql = 'select * from $tableName where id = $logId limit 1';
    Logger.d('要查询的SQL: $sql');
    var result = await storage.db.rawQuery(sql);
    Nano3MachineModel resultModel = Nano3MachineModel.fromJson(result.first);
    return resultModel;
  }
}
