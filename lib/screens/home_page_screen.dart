import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/persons.dart';
import '../widgets/refresh_fab.dart';
import '../widgets/user_list.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsProvider);
    final persons = personsAsync.hasValue ? personsAsync.value : null;
    const loadingIndicator = Center(child: CircularProgressIndicator());
    final body = switch (personsAsync) {
      AsyncData(:final isRefreshing) =>
        isRefreshing ? loadingIndicator : UserList(persons),
      AsyncError(:final isRefreshing) =>
        isRefreshing ? loadingIndicator : UserList(persons),
      AsyncLoading() => persons == null ? loadingIndicator : UserList(persons),
      _ => loadingIndicator,
    };
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: const Text('Users'),
      ),
      floatingActionButton: const RefreshFab(),
      body: body,
    );
  }
}
