import 'package:json_annotation/json_annotation.dart';

import '../../enum/device_status.dart';
part "device_create.g.dart";

@JsonSerializable()
class DeviceCreate {
  String vendor;
  DeviceStatus status;
  String gatewaySerialNumber;

  DeviceCreate({
    required this.vendor,
    required this.status,
    required this.gatewaySerialNumber,
  });

  factory DeviceCreate.fromJson(Map<String, dynamic> json) =>
      _$DeviceCreateFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceCreateToJson(this);
}
