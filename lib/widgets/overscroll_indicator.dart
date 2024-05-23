import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class OverscrollIndicator extends StatefulWidget {
  const OverscrollIndicator({
    super.key,
    required void Function() loadMoreCallback,
    required bool canLoadMore,
  })  : _loadMoreCallback = loadMoreCallback,
        _canLoadMore = canLoadMore;

  final void Function() _loadMoreCallback;
  final bool _canLoadMore;

  @override
  State<OverscrollIndicator> createState() => _OverscrollIndicatorState();
}

class _OverscrollIndicatorState extends State<OverscrollIndicator> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    if (!widget._canLoadMore) {
      return Text(
        'No more data',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      );
    }

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (kIsWeb) {
      return ElevatedButton(
        onPressed: _triggerLoading,
        child: const Text('Load More'),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _triggerLoading();
      });
      return Container();
    }
  }

  void _triggerLoading() {
    widget._loadMoreCallback();
    setState(() {
      _loading = true;
    });
  }
}
