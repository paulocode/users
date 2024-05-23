import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/person.dart';
import '../widgets/address_map.dart';
import '../widgets/avatar.dart';
import '../widgets/tappable_text.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              const SizedBox(height: 6),
              Avatar(url: _person.image, tag: _person, radius: 50),
              const SizedBox(height: 12),
              Text('${_person.firstname} ${_person.lastname}'),
              const SizedBox(height: 4),
              Text('Birthday: ${_person.birthday}'),
              const SizedBox(height: 4),
              Text('Gender: ${_person.gender}'),
              const SizedBox(height: 4),
              TappableText(_person.email, () {
                launchUrl(Uri(scheme: 'mailto', path: _person.email));
              }),
              const SizedBox(height: 4),
              TappableText(_person.phone, () {
                launchUrl(Uri(scheme: 'tel', path: _person.phone));
              }),
              const SizedBox(height: 4),
              TappableText(_person.website, () {
                launchUrl(
                  Uri.parse(_person.website ?? ''),
                  mode: LaunchMode.inAppWebView,
                );
              }),
              const SizedBox(height: 4),
              AddressMap(_person.address),
            ],
          ),
        ),
      ),
    );
  }
}
