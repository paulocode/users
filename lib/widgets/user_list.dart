import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/person.dart';
import '../providers/persons.dart';
import '../screens/user_screen.dart';
import 'avatar.dart';
import 'overscroll_indicator.dart';

class UserList extends ConsumerStatefulWidget {
  const UserList(List<Person>? persons, {super.key}) : _persons = persons;

  final List<Person>? _persons;

  @override
  ConsumerState<UserList> createState() => _UserListState();
}

class _UserListState extends ConsumerState<UserList> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final persons = widget._persons ?? [];
    final listView = ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (index == persons.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: OverscrollIndicator(
              canLoadMore: ref.read(personsProvider.notifier).canLoadMore(),
              loadMoreCallback: () {
                ref.read(personsProvider.notifier).loadNextPage();
              },
            ),
          );
        }
        final person = persons[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => UserScreen(person: person),
              ),
            );
          },
          child: ListTile(
            leading: Avatar(url: person.image, tag: person),
            title: Text('${person.firstname} ${person.lastname}'),
            subtitle: Text(person.email ?? ''),
          ),
        );
      },
      itemCount: persons.length + 1,
    );

    if (!kIsWeb) {
      return RefreshIndicator(
        onRefresh: () async {
          unawaited(ref.read(personsProvider.notifier).refresh());
        },
        child: listView,
      );
    } else {
      return listView;
    }
  }
}
