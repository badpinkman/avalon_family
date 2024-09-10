/// Nano3机器实体
class Nano3MachineModel {
  /*
    {
      "id": "ID_1",
      "online": false,
      "ip": "192.168.3.1",
      "ssid": "SSID_1",
      "model": "Nano 3",
      "remark": "Living Room",
      "version": "",
      "hversion": "",
      "firstFlag": true
    }
   */

  int? id;
  bool? online;
  String? ip;
  String? ssid;
  String? model;
  String? remark;
  String? version;
  String? hversion;
  bool? firstFlag;
  String? dna;

  Nano3MachineModel({
    this.id,
    this.online,
    this.ip,
    this.ssid,
    this.model,
    this.remark,
    this.version,
    this.hversion,
    this.firstFlag,
    this.dna,
  });

  Nano3MachineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    online = json['online'];
    ip = json['ip'];
    ssid = json['ssid'];
    model = json['model'];
    remark = json['remark'];
    version = json['version'];
    hversion = json['hversion'];
    firstFlag = json['firstFlag'];
    dna = json['dna'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['online'] = online;
    data['ip'] = ip;
    data['ssid'] = ssid;
    data['model'] = model;
    data['remark'] = remark;
    data['version'] = version;
    data['hversion'] = hversion;
    data['firstFlag'] = firstFlag;
    data['dna'] = dna;
    return data;
  }
}
