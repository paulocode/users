import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/address.dart';

class AddressMap extends StatelessWidget {
  const AddressMap(Address? address, {super.key}) : _address = address;

  final Address? _address;

  @override
  Widget build(BuildContext context) {
    if (_address == null) {
      return Container();
    }
    return Column(
      children: [
        TextButton(
          onPressed: () {
            final isIOS = kIsWeb || !Platform.isIOS;
            launchUrl(
              isIOS
                  ? Uri.parse(
                      'https://www.google.com/maps/@${_address.latitude},${_address.longitude},14z',
                    )
                  : Uri.parse(
                      'https://maps.apple.com/?ll=${_address.latitude},${_address.longitude}',
                    ),
            );
          },
          child: Text(
            'Address: ${_address.street} ${_address.streetName} St., Bldg No. ${_address.buildingNumber}, ${_address.city}, ${_address.country}',
          ),
        ),
      ],
    );
  }
}
