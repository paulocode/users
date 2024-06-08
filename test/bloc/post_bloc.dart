import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:users/bloc/person/person_bloc.dart';
import 'package:users/model/fakeapi_person_response.dart';
import 'package:users/model/person.dart';

import 'post_bloc.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group(PersonBloc, () {
    late PersonBloc personBloc;
    late MockClient client;

    setUp(() {
      personBloc = PersonBloc(httpClient: client = MockClient());
    });

    blocTest<PersonBloc, PersonState>(
      'test initial load',
      build: () => personBloc,
      setUp: () => _setClientResponse(
        client,
        [const Person(id: 0, firstname: 'juan', lastname: 'cruz')],
      ),
      wait: const Duration(milliseconds: 600),
      act: (bloc) => bloc.add(PersonRefreshed()),
      skip: 2,
      expect: () => [
        const PersonState(
          loadCount: 1,
          persons: [Person(id: 0, firstname: 'juan', lastname: 'cruz')],
        ),
      ],
    );
  });
}

void _setClientResponse(
  MockClient client,
  List<Person> data, {
  int code = 200,
}) {
  when(client.get(any)).thenAnswer(
    (_) => Future.value(
      http.Response(
        jsonEncode(
          FakeapiPersonResponse(
            data: data,
          ).toJson(),
        ),
        code,
      ),
    ),
  );
}
