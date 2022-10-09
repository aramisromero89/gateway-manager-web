import 'package:json_annotation/json_annotation.dart';
part "id_string.g.dart";

@JsonSerializable()
class IdString {
  String id;

  IdString({
    required this.id,
  });

  factory IdString.fromJson(Map<String, dynamic> json) =>
      _$IdStringFromJson(json);
  Map<String, dynamic> toJson() => _$IdStringToJson(this);
}
