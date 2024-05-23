import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:users/model/fakeapi_person_response.dart';
import 'package:users/model/person.dart';
import 'package:users/providers/http.dart';
import 'package:users/providers/persons.dart';

import '../common.dart';
import 'persons.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ProviderContainer container;
  late MockClient client;
  setUp(() {
    client = MockClient();
    container = createContainer(
      overrides: [
        httpClientProvider.overrideWith(
          (ref) => client,
        ),
      ],
    );
  });

  test('test initial load', () async {
    _setClientResponse(
      client,
      [Person(id: 0, firstname: 'juan', lastname: 'cruz')],
    );

    final persons = await container.read(personsProvider.future);
    expect(persons.length, 1);
    expect(persons[0].id, 0);
    expect(persons[0].firstname, 'juan');
    expect(persons[0].lastname, 'cruz');
  });

  test('test 2nd load', () async {
    _setClientResponse(
      client,
      [Person(id: 0, firstname: 'juan', lastname: 'cruz')],
    );
    await container.read(personsProvider.future);
    _setClientResponse(
      client,
      [Person(id: 0, firstname: 'juana', lastname: 'santos')],
    );
    await container.read(personsProvider.notifier).loadNextPage();
    final persons = await container.read(personsProvider.future);

    expect(persons.length, 2);
    expect(persons[0].id, 0);
    expect(persons[0].firstname, 'juan');
    expect(persons[0].lastname, 'cruz');
    expect(persons[1].id, 0);
    expect(persons[1].firstname, 'juana');
    expect(persons[1].lastname, 'santos');
  });

  test('canLoadMore must be true after first load', () async {
    _setClientResponse(
      client,
      [Person(id: 0, firstname: 'juan', lastname: 'cruz')],
    );
    await container.read(personsProvider.future);
    expect(container.read(personsProvider.notifier).canLoadMore(), true);
  });

  test('4th load must set canLoadMore to false', () async {
    _setClientResponse(
      client,
      [Person(id: 0, firstname: 'juan', lastname: 'cruz')],
    );
    await container.read(personsProvider.future);
    await container.read(personsProvider.notifier).loadNextPage();
    await container.read(personsProvider.notifier).loadNextPage();
    await container.read(personsProvider.notifier).loadNextPage();

    expect(container.read(personsProvider.notifier).canLoadMore(), false);
  });

  test('after 4th load must not load any more person', () async {
    _setClientResponse(
      client,
      [Person(id: 0, firstname: 'juan', lastname: 'cruz')],
    );
    await container.read(personsProvider.future);
    await container.read(personsProvider.notifier).loadNextPage();
    await container.read(personsProvider.notifier).loadNextPage();
    await container.read(personsProvider.notifier).loadNextPage();
    await container.read(personsProvider.notifier).loadNextPage(); // 5th load
    await container.read(personsProvider.notifier).loadNextPage(); // 6th load

    final persons = await container.read(personsProvider.future);

    expect(persons.length, 4);
  });

  test('refresh must clear previous', () async {
    _setClientResponse(
      client,
      [Person(id: 0, firstname: 'juan', lastname: 'cruz')],
    );
    await container.read(personsProvider.future);
    await container.read(personsProvider.notifier).refresh();

    final persons = await container.read(personsProvider.future);

    expect(persons.length, 1);
  });
}

void _setClientResponse(MockClient client, List<Person> data) {
  when(client.get(any)).thenAnswer(
    (_) => Future.value(
      http.Response(
        jsonEncode(
          FakeapiPersonResponse(
            data: data,
          ).toJson(),
        ),
        200,
      ),
    ),
  );
}
