import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  Person({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.image,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? image;

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
