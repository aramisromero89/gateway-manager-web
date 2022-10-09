import 'package:json_annotation/json_annotation.dart';

import '../../enum/device_status.dart';
import 'device_create.dart';
part "device_edit.g.dart";

@JsonSerializable()
class DeviceEdit extends DeviceCreate {
  int id;

  DeviceEdit({
    required this.id,
    required String vendor,
    required DateTime date,
    required DeviceStatus status,
    required String gatewaySerialNumber,
  }) : super(
            date: date,
            gatewaySerialNumber: gatewaySerialNumber,
            status: status,
            vendor: vendor);

  factory DeviceEdit.fromJson(Map<String, dynamic> json) =>
      _$DeviceEditFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeviceEditToJson(this);
}
