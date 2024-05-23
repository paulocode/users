import 'package:json_annotation/json_annotation.dart';
import 'person.dart';
part 'fakeapi_person_response.g.dart';

@JsonSerializable()
class FakeapiPersonResponse {
  FakeapiPersonResponse({
    this.data,
  });

  factory FakeapiPersonResponse.fromJson(Map<String, dynamic> json) =>
      _$FakeapiPersonResponseFromJson(json);

  List<Person>? data;

  Map<String, dynamic> toJson() => _$FakeapiPersonResponseToJson(this);
}
