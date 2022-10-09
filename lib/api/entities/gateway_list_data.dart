import 'package:gateway_manager_client/api/entities/device.dart';
import 'package:gateway_manager_client/api/entities/gateway.dart';
import 'package:json_annotation/json_annotation.dart';
part "gateway_list_data.g.dart";

@JsonSerializable()
class GatewayListData {
  int total;
  List<Gateway> items;

  GatewayListData({
    required this.total,
    required this.items,
  });

  factory GatewayListData.fromJson(Map<String, dynamic> json) =>
      _$GatewayListDataFromJson(json);
  Map<String, dynamic> toJson() => _$GatewayListDataToJson(this);
}
