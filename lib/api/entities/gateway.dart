import 'package:gateway_manager_client/api/entities/device.dart';
import 'package:json_annotation/json_annotation.dart';
part "gateway.g.dart";

@JsonSerializable()
class Gateway {
  String serialNumber;
  String name;
  String address;
  int? devicesCount;

  Gateway({
    required this.serialNumber,
    required this.name,
    required this.address,
    required this.devicesCount,
  });

  factory Gateway.fromJson(Map<String, dynamic> json) =>
      _$GatewayFromJson(json);
  Map<String, dynamic> toJson() => _$GatewayToJson(this);
}
