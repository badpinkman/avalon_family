import 'package:avalon_family/common/index.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();

  List<Nano3MachineModel> nano3List = [];
  List<MiniMachineModel> miniList = [];

  _initData() async {
    nano3List = await DbService.to.nano3MachineDao.getNano3MachineList();
    mockNano3Data();
    mockMiniData();
    update(["home"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void mockNano3Data() {
    nano3List.add(Nano3MachineModel(
        id: 1,
        ip: '192.168.3.3',
        ssid: 'CAN',
        model: 'Nano3',
        remark: 'Living Room',
        dna: 'abcde'));
    nano3List.add(Nano3MachineModel(
        id: 2,
        ip: '192.168.3.3',
        ssid: 'CAN',
        model: 'Nano3',
        remark: 'Living Room',
        dna: 'abcde'));
    nano3List.add(Nano3MachineModel(
        id: 3,
        ip: '192.168.3.3',
        ssid: 'CAN',
        model: 'Nano3',
        remark: 'Living Room',
        dna: 'abcde'));
    nano3List.add(Nano3MachineModel(
        id: 4,
        ip: '192.168.3.3',
        ssid: 'CAN',
        model: 'Nano3',
        remark: 'Living Room',
        dna: 'abcde'));
    nano3List.add(Nano3MachineModel(
        id: 5,
        ip: '192.168.3.3',
        ssid: 'CAN',
        model: 'Nano3',
        remark: 'Living Room',
        dna: 'abcde'));

    update(['nano3CardList']);
  }

  void mockMiniData() {
    miniList.add(MiniMachineModel(
        id: 1,
        ip: '193.168.2.1',
        ssid: 'CAN',
        model: 'Mini',
        remark: 'Living Room',
        dna: 'abcde'));
    miniList.add(MiniMachineModel(
        id: 2,
        ip: '193.168.2.2',
        ssid: 'CAN',
        model: 'Mini',
        remark: 'Living Room',
        dna: 'abcde'));
    miniList.add(MiniMachineModel(
        id: 3,
        ip: '193.168.2.3',
        ssid: 'CAN',
        model: 'Mini',
        remark: 'Living Room',
        dna: 'abcde'));
    update(['miniCardList']);
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
