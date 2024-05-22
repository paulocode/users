import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/fakeapi_person_response.dart';
import '../model/person.dart';

part 'persons.g.dart';

@riverpod
Future<List<Person>> persons(PersonsRef ref) async {
  final response = await http
      .get(Uri.https('fakerapi.it', '/api/v1/persons', {'_quantity': '10'}));
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return FakeapiPersonResponse.fromJson(json).data ?? [];
}
