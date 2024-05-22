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
    return Text('${_person.firstname}');
  }
}
