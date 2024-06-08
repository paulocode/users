import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/person/person_bloc.dart'
    show PersonBloc, PersonFetched, PersonRefreshed, PersonState;
import '../screens/person_screen.dart';
import 'avatar.dart';
import 'overscroll_indicator.dart';

class PersonList extends StatefulWidget {
  const PersonList({super.key});
  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom && !kIsWeb) context.read<PersonBloc>().add(PersonFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonBloc, PersonState>(
      builder: (context, state) {
        final persons = state.persons;
        final listView = ListView.builder(
          controller: _scrollController,
          itemCount: persons.length + 1,
          itemBuilder: (context, index) {
            if (index == persons.length) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: OverscrollIndicator(
                  canLoadMore: !state.hasReachedMax,
                  loadMoreCallback: () {
                    context.read<PersonBloc>().add(PersonFetched());
                  },
                  isLoading: state.isLoading,
                  hasError: state.hasError,
                ),
              );
            }
            final person = persons[index];
            return InkWell(
              onTap: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => PersonScreen(person: person),
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
        );

        if (!kIsWeb) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<PersonBloc>().add(PersonRefreshed());
            },
            child: listView,
          );
        } else {
          return listView;
        }
      },
    );
  }
}
