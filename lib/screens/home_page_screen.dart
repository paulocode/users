import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users/screens/user_screen.dart';

import '../providers/persons.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsProvider);
    final body = switch (personsAsync) {
      AsyncData(:final value) => ListView.builder(
          itemBuilder: (context, index) {
            final person = value[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserScreen(person: person)));
              },
              child: ListTile(
                leading: Hero(tag: person, child: const CircleAvatar()),
                title: Text('${person.firstname} ${person.lastname}'),
              ),
            );
          },
          itemCount: value.length,
        ),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const Center(child: CircularProgressIndicator()),
    };
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: const Text('Users'),
      ),
      body: body,
    );
  }
}
