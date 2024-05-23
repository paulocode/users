import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'http.g.dart';

@riverpod
http.Client httpClient(HttpClientRef ref) {
  return http.Client();
}
