import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users/providers/persons.dart';

import '../model/person.dart';
import '../screens/user_screen.dart';

class UserList extends ConsumerWidget {
  const UserList(List<Person> persons, {super.key}) : _persons = persons;

  final List<Person> _persons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(personsProvider);
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          final person = _persons[index];
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
        itemCount: _persons.length,
      ),
    );
  }
}
