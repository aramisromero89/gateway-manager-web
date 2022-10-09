import 'package:json_annotation/json_annotation.dart';
part "id_int.g.dart";

@JsonSerializable()
class IdInt {
  int id;

  IdInt({
    required this.id,
  });

  factory IdInt.fromJson(Map<String, dynamic> json) => _$IdIntFromJson(json);
  Map<String, dynamic> toJson() => _$IdIntToJson(this);
}
