import 'package:json_annotation/json_annotation.dart';

import '../enum/device_status.dart';
part "device.g.dart";

@JsonSerializable()
class Device {
  int id;
  String vendor;
  DateTime date;
  DeviceStatus status;
  String gatewaySerialNumber;

  Device({
    required this.id,
    required this.vendor,
    required this.date,
    required this.status,
    required this.gatewaySerialNumber,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
