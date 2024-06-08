import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address extends Equatable {
  const Address({
    this.id,
    this.street,
    this.streetName,
    this.buildingNumber,
    this.city,
    this.zipcode,
    this.country,
    this.countyCode,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  final int? id;
  final String? street;
  final String? streetName;
  final String? buildingNumber;
  final String? city;
  final String? zipcode;
  final String? country;
  final String? countyCode;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [
        id,
        street,
        streetName,
        buildingNumber,
        city,
        zipcode,
        country,
        countyCode,
        latitude,
        longitude,
      ];
}
