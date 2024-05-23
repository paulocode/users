import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required String? url,
    double? radius,
    required Object tag,
  })  : _url = url,
        _radius = radius,
        _tag = tag;

  final String? _url;
  final Object _tag;
  final double? _radius;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _tag,
      child: CircleAvatar(
        radius: _radius,
        child: Image.network(
          _url ?? '',
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.person),
        ),
      ),
    );
  }
}
