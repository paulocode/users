import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../constants.dart';
import '../../model/fakeapi_person_response.dart';
import '../../model/person.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc({required this.httpClient}) : super(const PersonState()) {
    on<PersonFetched>(_onPersonFetched);
    on<PersonRefreshed>(_onPersonRefreshed);
  }

  final http.Client httpClient;
  final _logger = Logger();

  Future<void> _onPersonFetched(
    PersonFetched event,
    Emitter<PersonState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoading) {
      return;
    }

    await _loadPersons(itemsPerFetch, emit);
  }

  Future<void> _onPersonRefreshed(
    PersonRefreshed event,
    Emitter<PersonState> emit,
  ) async {
    if (state.isLoading) {
      return;
    }
    emit(state.copyWith(persons: [], loadCount: 0));
    await _loadPersons(initialItemsPerFetch, emit);
  }

  Future<void> _loadPersons(int count, Emitter<PersonState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, hasError: false));
      _logger.i('Loading persons...');
      await Future<void>.delayed(const Duration(milliseconds: 500));

      final uri = Uri.https(
        baseFakerApiUrl,
        personsFakerApiPath,
        {quantityFakerApiArg: count.toString()},
      );
      _logger.i(uri.toString());
      final response = await httpClient.get(uri);
      _logger.i(response.body);

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final list = FakeapiPersonResponse.fromJson(json).data ?? [];
      _logger.i('Loaded page ${state.loadCount + 1}');
      emit(
        state.copyWith(
          persons: [...state.persons, ...list],
          loadCount: state.loadCount + 1,
          isLoading: false,
        ),
      );
    } on Exception catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
