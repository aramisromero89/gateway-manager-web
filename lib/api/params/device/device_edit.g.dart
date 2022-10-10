// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceEdit _$DeviceEditFromJson(Map<String, dynamic> json) => DeviceEdit(
      id: json['id'] as int,
      vendor: json['vendor'] as String,
      status: $enumDecode(_$DeviceStatusEnumMap, json['status']),
      gatewaySerialNumber: json['gatewaySerialNumber'] as String,
    );

Map<String, dynamic> _$DeviceEditToJson(DeviceEdit instance) =>
    <String, dynamic>{
      'vendor': instance.vendor,
      'status': _$DeviceStatusEnumMap[instance.status]!,
      'gatewaySerialNumber': instance.gatewaySerialNumber,
      'id': instance.id,
    };

const _$DeviceStatusEnumMap = {
  DeviceStatus.online: 'online',
  DeviceStatus.offline: 'offline',
};
