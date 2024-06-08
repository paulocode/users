import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'person.g.dart';

@JsonSerializable()
class Person extends Equatable {
  const Person({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.birthday,
    this.gender,
    this.address,
    this.website,
    this.image,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  final int? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phone;
  final String? birthday;
  final String? gender;
  final Address? address;
  final String? website;
  final String? image;

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        email,
        phone,
        birthday,
        gender,
        address,
        website,
        image,
      ];
}
