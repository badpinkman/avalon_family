import 'package:avalon_family/common/index.dart';
import 'package:get/get.dart';

class DbService extends GetxService {
  // 这是一个单例写法
  static DbService get to => Get.find();

  Nano3MachineDao? _nano3MachineDao;

  /// 机器dao
  Nano3MachineDao get nano3MachineDao => _nano3MachineDao!;

  // 初始化
  Future<DbService> init() async {
    await _initDb();
    return this;
  }

  _initDb() async {
    var dbManager = await DBManager.instance(dbName: Constants.initDbName);
    _nano3MachineDao = Nano3MachineDao(storage: dbManager);
  }
}
