import 'package:json_annotation/json_annotation.dart';
part "gateway_create.g.dart";

@JsonSerializable()
class GatewayCreate {
  String name;

  String address;

  GatewayCreate({
    required this.name,
    required this.address,
  });

  factory GatewayCreate.fromJson(Map<String, dynamic> json) =>
      _$GatewayCreateFromJson(json);
  Map<String, dynamic> toJson() => _$GatewayCreateToJson(this);
}
