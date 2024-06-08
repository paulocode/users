import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class RefreshFab extends StatelessWidget {
  const RefreshFab({super.key, required this.refreshCallback});
  final void Function() refreshCallback;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        icon: const Icon(
          Icons.refresh,
          size: 70,
        ),
        onPressed: () async {
          refreshCallback();
        },
      ),
    );
  }
}
