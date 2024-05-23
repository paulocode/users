import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/persons.dart';

class RefreshFab extends ConsumerWidget {
  const RefreshFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onPressed: () {
          ref.invalidate(personsProvider);
        },
      ),
    );
  }
}
