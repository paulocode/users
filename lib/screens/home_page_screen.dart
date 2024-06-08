import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../bloc/post_bloc.dart';
import '../widgets/refresh_fab.dart';
import '../widgets/user_list.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.person),
          title: const Text('Users'),
        ),
        floatingActionButton: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return RefreshFab(
              refreshCallback: () {
                context.read<PostBloc>().add(PostRefreshed());
              },
            );
          },
        ),
        body: const UserList(),
      ),
    );
  }
}
