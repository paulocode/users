import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users/widgets/refresh_fab.dart';

import '../providers/persons.dart';
import '../widgets/user_list.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsProvider);
    final body = switch (personsAsync) {
      AsyncData(:final value, :final isLoading) => !isLoading
          ? UserList(value)
          : const Center(child: CircularProgressIndicator()),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const Center(child: CircularProgressIndicator()),
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
