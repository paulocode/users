import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/person.dart';
import '../providers/persons.dart';
import '../widgets/refresh_fab.dart';
import '../widgets/user_list.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsProvider);
    const loadingIndicator = Center(child: CircularProgressIndicator());
    late final Widget body;

    if (personsAsync.isRefreshing) {
      body = loadingIndicator;
    } else if (personsAsync.isLoading) {
      body = personsAsync.hasValue
          ? UserList(personsAsync.value!)
          : loadingIndicator;
    } else {
      body = UserList(personsAsync.hasValue ? personsAsync.value! : <Person>[]);
    }

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
