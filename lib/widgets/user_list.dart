import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart'
    show PostBloc, PostFetched, PostRefreshed, PostState;
import '../screens/user_screen.dart';
import 'avatar.dart';
import 'overscroll_indicator.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
    if (_isBottom && !kIsWeb) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        final persons = state.posts;
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
                    context.read<PostBloc>().add(PostFetched());
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
        );

        if (!kIsWeb) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<PostBloc>().add(PostRefreshed());
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
