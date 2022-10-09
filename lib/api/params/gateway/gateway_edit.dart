import 'package:json_annotation/json_annotation.dart';

import '../../enum/device_status.dart';
import 'gateway_create.dart';
part "gateway_edit.g.dart";

@JsonSerializable()
class GatewayEdit extends GatewayCreate {
  String serialNumber;

  GatewayEdit({
    required this.serialNumber,
    required String address,
    required String name,
  }) : super(
          address: address,
          name: name,
        );

  factory GatewayEdit.fromJson(Map<String, dynamic> json) =>
      _$GatewayEditFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GatewayEditToJson(this);
}
