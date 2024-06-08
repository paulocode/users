import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:users/bloc/person/person_bloc.dart';

import 'post_bloc.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group(PersonBloc, () {
    late PersonBloc personBloc;

    setUp(() {
      personBloc = PersonBloc(httpClient: MockClient());
    });
  });
}
