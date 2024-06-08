import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/fakeapi_person_response.dart';
import '../model/person.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(_onPostFetched);
    on<PostRefreshed>(_onPostRefreshed);
  }

  final http.Client httpClient;
  final _logger = Logger();

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoading) {
      return;
    }

    await _loadPersons(kItemsPerFetch, emit);
  }

  Future<void> _onPostRefreshed(
    PostRefreshed event,
    Emitter<PostState> emit,
  ) async {
    if (state.isLoading) {
      return;
    }

    emit(state.copyWith(posts: [], loadCount: 0));
    await _loadPersons(kItemsPerFetch, emit);
  }

  Future<void> _loadPersons(int count, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      _logger.i('Loading persons...');
      await Future<void>.delayed(const Duration(milliseconds: 500));

      final uri = Uri.https(
        kBaseFakerApiUrl,
        kPersonsFakerApiPath,
        {kQuantityFakerApiArg: count.toString()},
      );
      _logger.i(uri.toString());
      final response = await httpClient.get(uri);
      _logger.i(response.body);

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final list = FakeapiPersonResponse.fromJson(json).data ?? [];
      _logger.i('Loaded page ${state.loadCount + 1}');
      emit(
        state.copyWith(
          posts: [...state.posts, ...list],
          loadCount: state.loadCount + 1,
          isLoading: false,
        ),
      );
    } on Exception catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
