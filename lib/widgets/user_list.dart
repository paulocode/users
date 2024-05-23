import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/person.dart';
import '../providers/persons.dart';
import '../screens/user_screen.dart';

class UserList extends ConsumerWidget {
  const UserList(List<Person> persons, {super.key}) : _persons = persons;

  final List<Person> _persons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listView = ListView.builder(
      itemBuilder: (context, index) {
        final person = _persons[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => UserScreen(person: person),
              ),
            );
          },
          child: ListTile(
            leading: Hero(tag: person, child: const CircleAvatar()),
            title: Text('${person.firstname} ${person.lastname}'),
          ),
        );
      },
      itemCount: _persons.length,
    );

    if (!kIsWeb) {
      return RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(personsProvider);
        },
        child: listView,
      );
    } else {
      return listView;
    }
  }
}
