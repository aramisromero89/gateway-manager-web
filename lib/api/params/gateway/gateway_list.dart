import 'package:json_annotation/json_annotation.dart';
part "gateway_list.g.dart";

@JsonSerializable()
class GatewayList {
  int count;

  int page;

  GatewayList({
    required this.count,
    required this.page,
  });

  factory GatewayList.fromJson(Map<String, dynamic> json) =>
      _$GatewayListFromJson(json);
  Map<String, dynamic> toJson() => _$GatewayListToJson(this);
}
