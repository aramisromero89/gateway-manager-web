// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceCreate _$DeviceCreateFromJson(Map<String, dynamic> json) => DeviceCreate(
      vendor: json['vendor'] as String,
      status: $enumDecode(_$DeviceStatusEnumMap, json['status']),
      gatewaySerialNumber: json['gatewaySerialNumber'] as String,
    );

Map<String, dynamic> _$DeviceCreateToJson(DeviceCreate instance) =>
    <String, dynamic>{
      'vendor': instance.vendor,
      'status': _$DeviceStatusEnumMap[instance.status]!,
      'gatewaySerialNumber': instance.gatewaySerialNumber,
    };

const _$DeviceStatusEnumMap = {
  DeviceStatus.online: 'online',
  DeviceStatus.offline: 'offline',
};
