import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../model/fakeapi_person_response.dart';
import '../model/person.dart';
import 'http.dart';

part 'persons.g.dart';

@Riverpod(keepAlive: true)
class Persons extends _$Persons {
  final _logger = Logger();
  var _loadCount = 0;

  @override
  Future<List<Person>> build() async {
    _loadCount = 0;
    return _loadPersons(kInitialItemsPerFetch);
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !canLoadMore()) {
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final newPersons = await _loadPersons(kItemsPerFetch);
      return [...state.value ?? [], ...newPersons];
    });
  }

  Future<List<Person>> _loadPersons(int count) async {
    _logger.i('Loading persons...');
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final uri = Uri.https(
      kBaseFakerApiUrl,
      kPersonsFakerApiPath,
      {kQuantityFakerApiArg: count.toString()},
    );
    _logger.i(uri.toString());

    final response = await ref.read(httpClientProvider).get(uri);
    _logger.i(response.body);

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    _loadCount++;
    _logger.i('Loaded page $_loadCount');
    return FakeapiPersonResponse.fromJson(json).data ?? [];
  }

  bool canLoadMore() {
    return _loadCount < kPagesLimit;
  }

  Future<void> refresh() async {
    _loadCount = 0;
    state = const AsyncData([]);
    await loadNextPage();
  }
}
