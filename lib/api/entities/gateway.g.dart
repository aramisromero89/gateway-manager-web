// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gateway.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gateway _$GatewayFromJson(Map<String, dynamic> json) => Gateway(
      serialNumber: json['serialNumber'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      devices: (json['devices'] as List<dynamic>?)
          ?.map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GatewayToJson(Gateway instance) => <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'name': instance.name,
      'address': instance.address,
      'devices': instance.devices,
    };
