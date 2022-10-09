import 'package:json_annotation/json_annotation.dart';

enum DeviceStatus {
  @JsonValue("online")
  online,
  @JsonValue("offline")
  offline,
}
