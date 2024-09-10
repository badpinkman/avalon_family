/// Mini机器实体
class MiniMachineModel {
  /*
  {
    "id": "fWBkUcou5319fr5CptVGN",
    "wifiSsid": "CAN",
    "wifiIp": "10.100.200.136",
    "remark": "Living Room",
    "online": false,
    "machineNo": "mini3_0000",
    "model": "Mini",
    "version": "24090532",
    "firstFlag": true,
    "hwtype": "MM4v2_X3",
    "swtype": "MM319",
    "barcode": "6931925828032",
    "timezone": "Asia/Shanghai",
    "password": "66666"
  }
   */

  int? id;
  String? ssid;
  String? ip;
  String? remark;
  bool? online;
  String? machineNo;
  String? model;
  String? version;
  bool? firstFlag;
  String? hwtype;
  String? swtype;
  String? barcode;
  String? timezone;
  String? password;
  String? dna;

  MiniMachineModel({
    this.id,
    this.ssid,
    this.ip,
    this.remark,
    this.online,
    this.machineNo,
    this.model,
    this.version,
    this.firstFlag,
    this.hwtype,
    this.swtype,
    this.barcode,
    this.timezone,
    this.password,
    this.dna,
  });

  MiniMachineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ssid = json['ssid'];
    ip = json['ip'];
    remark = json['remark'];
    online = json['online'];
    machineNo = json['machineNo'];
    model = json['model'];
    version = json['version'];
    firstFlag = json['firstFlag'];
    hwtype = json['hwtype'];
    swtype = json['swtype'];
    barcode = json['barcode'];
    timezone = json['timezone'];
    password = json['password'];
    dna = json['dna'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ssid'] = ssid;
    data['ip'] = ip;
    data['remark'] = remark;
    data['online'] = online;
    data['machineNo'] = machineNo;
    data['model'] = model;
    data['version'] = version;
    data['firstFlag'] = firstFlag;
    data['hwtype'] = hwtype;
    data['swtype'] = swtype;
    data['barcode'] = barcode;
    data['timezone'] = timezone;
    data['password'] = password;
    data['dna'] = dna;
    return data;
  }
}
