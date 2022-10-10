// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gateway.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gateway _$GatewayFromJson(Map<String, dynamic> json) => Gateway(
      serialNumber: json['serialNumber'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      devicesCount: json['devicesCount'] as int?,
    );

Map<String, dynamic> _$GatewayToJson(Gateway instance) => <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'name': instance.name,
      'address': instance.address,
      'devicesCount': instance.devicesCount,
    };
