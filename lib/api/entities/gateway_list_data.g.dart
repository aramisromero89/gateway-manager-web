// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gateway_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GatewayListData _$GatewayListDataFromJson(Map<String, dynamic> json) =>
    GatewayListData(
      total: json['total'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => Gateway.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GatewayListDataToJson(GatewayListData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'items': instance.items,
    };
