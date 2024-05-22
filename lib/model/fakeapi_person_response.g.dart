// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fakeapi_person_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FakeapiPersonResponse _$FakeapiPersonResponseFromJson(
        Map<String, dynamic> json) =>
    FakeapiPersonResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FakeapiPersonResponseToJson(
        FakeapiPersonResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
