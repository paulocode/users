import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'fetch_failed.dart';

class OverscrollIndicator extends StatefulWidget {
  const OverscrollIndicator({
    super.key,
    required this.loadMoreCallback,
    required this.canLoadMore,
    required this.isLoading,
    required this.hasError,
  });

  final void Function() loadMoreCallback;
  final bool canLoadMore;
  final bool isLoading;
  final bool hasError;

  @override
  State<OverscrollIndicator> createState() => _OverscrollIndicatorState();
}

class _OverscrollIndicatorState extends State<OverscrollIndicator> {
  @override
  Widget build(BuildContext context) {
    if (!widget.canLoadMore) {
      return Text(
        'No more data',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      );
    }

    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (widget.hasError) {
      return SizedBox(
        width: double.infinity,
        child: FetchFailed(
          retryCallback: widget.loadMoreCallback,
        ),
      );
    } else if (kIsWeb) {
      return ElevatedButton(
        onPressed: widget.loadMoreCallback,
        child: const Text('Load More'),
      );
    } else {
      return Container();
    }
  }
}
