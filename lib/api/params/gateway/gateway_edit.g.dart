// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gateway_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GatewayEdit _$GatewayEditFromJson(Map<String, dynamic> json) => GatewayEdit(
      serialNumber: json['serialNumber'] as String,
      address: json['address'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$GatewayEditToJson(GatewayEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'serialNumber': instance.serialNumber,
    };
