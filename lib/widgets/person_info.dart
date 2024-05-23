import 'package:flutter/material.dart';

class PersonInfo extends StatelessWidget {
  const PersonInfo(IconData icon, String label, Widget value, {super.key})
      : _icon = icon,
        _label = label,
        _value = value;

  final IconData _icon;
  final String _label;
  final Widget _value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_icon),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            _label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(child: _value),
      ],
    );
  }
}
