import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../bloc/person/person_bloc.dart';
import '../widgets/person_list.dart';
import '../widgets/refresh_fab.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PersonBloc(httpClient: http.Client())..add(PersonRefreshed()),
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.person),
          title: const Text('Persons'),
        ),
        floatingActionButton: BlocBuilder<PersonBloc, PersonState>(
          builder: (context, state) {
            return RefreshFab(
              refreshCallback: () {
                context.read<PersonBloc>().add(PersonRefreshed());
              },
            );
          },
        ),
        body: const PersonList(),
      ),
    );
  }
}
