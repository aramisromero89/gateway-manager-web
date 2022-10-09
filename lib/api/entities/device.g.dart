// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as int,
      vendor: json['vendor'] as String,
      date: DateTime.parse(json['date'] as String),
      status: $enumDecode(_$DeviceStatusEnumMap, json['status']),
      gatewaySerialNumber: json['gatewaySerialNumber'] as String,
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'vendor': instance.vendor,
      'date': instance.date.toIso8601String(),
      'status': _$DeviceStatusEnumMap[instance.status]!,
      'gatewaySerialNumber': instance.gatewaySerialNumber,
    };

const _$DeviceStatusEnumMap = {
  DeviceStatus.online: 'online',
  DeviceStatus.offline: 'offline',
};
