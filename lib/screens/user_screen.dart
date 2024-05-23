import 'package:flutter/material.dart';

import '../model/person.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({
    super.key,
    required Person person,
  }) : _person = person;

  final Person _person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${_person.firstname}'s Information")),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Hero(
              tag: _person,
              child: const CircleAvatar(
                radius: 50,
              ),
            ),
            const SizedBox(height: 15),
            Text('${_person.firstname} ${_person.lastname}'),
          ],
        ),
      ),
    );
  }
}
