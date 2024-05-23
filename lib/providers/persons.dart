import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/fakeapi_person_response.dart';
import '../model/person.dart';
import 'http.dart';

part 'persons.g.dart';

@Riverpod(keepAlive: true)
class Persons extends _$Persons {
  var _isLoadingNextPage = false;
  final _logger = Logger();
  var _loadCount = 0;

  @override
  Future<List<Person>> build() async {
    _loadCount = 0;
    return _loadPersons();
  }

  Future<void> loadNextPage() async {
    if (_isLoadingNextPage || !canLoadMore()) {
      return;
    }
    _isLoadingNextPage = true;
    final newPersons = await _loadPersons();
    state = AsyncData([...state.value!, ...newPersons]);
    _isLoadingNextPage = false;
  }

  Future<List<Person>> _loadPersons() async {
    _logger.i('Loading persons...');
    final response = await ref
        .read(httpClientProvider)
        .get(Uri.https('fakerapi.it', '/api/v1/persons', {'_quantity': '10'}));
    _logger.i(response.request?.url.toString());
    _logger.i(response.body);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    _loadCount++;
    _logger.i('Loaded page $_loadCount');
    return FakeapiPersonResponse.fromJson(json).data ?? [];
  }

  bool canLoadMore() {
    return _loadCount < 4;
  }
}
