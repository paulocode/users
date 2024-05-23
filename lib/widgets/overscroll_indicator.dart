import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/persons.dart';
import 'fetch_failed.dart';

class OverscrollIndicator extends ConsumerStatefulWidget {
  const OverscrollIndicator({
    super.key,
    required void Function() loadMoreCallback,
    required bool canLoadMore,
  })  : _loadMoreCallback = loadMoreCallback,
        _canLoadMore = canLoadMore;

  final void Function() _loadMoreCallback;
  final bool _canLoadMore;

  @override
  ConsumerState<OverscrollIndicator> createState() =>
      _OverscrollIndicatorState();
}

class _OverscrollIndicatorState extends ConsumerState<OverscrollIndicator> {
  @override
  Widget build(BuildContext context) {
    final personsAsync = ref.read(personsProvider);

    if (!widget._canLoadMore) {
      return Text(
        'No more data',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      );
    }

    if (personsAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (personsAsync.hasError) {
      return SizedBox(
        width: double.infinity,
        child: FetchFailed(
          retryCallback: widget._loadMoreCallback,
        ),
      );
    } else if (kIsWeb) {
      return ElevatedButton(
        onPressed: widget._loadMoreCallback,
        child: const Text('Load More'),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget._loadMoreCallback();
      });
      return Container();
    }
  }
}
