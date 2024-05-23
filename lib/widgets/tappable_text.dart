import 'package:flutter/material.dart';

class TappableText extends StatelessWidget {
  const TappableText(String? text, void Function() callback, {super.key})
      : _text = text,
        _callback = callback;

  final String? _text;
  final void Function() _callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _callback,
      child: Text(
        _text ?? '',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
