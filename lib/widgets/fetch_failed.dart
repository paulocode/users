import 'package:flutter/material.dart';

class FetchFailed extends StatelessWidget {
  const FetchFailed({super.key, required void Function() retryCallback})
      : _retryCallback = retryCallback;

  final void Function() _retryCallback;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _retryCallback,
      child: const Text('Fetch failed. Tap to retry.'),
    );
  }
}
