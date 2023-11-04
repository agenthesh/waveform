import 'package:flutter/widgets.dart';

/// A StatefulWidget that builds a sliver list from a stream of data,
/// animating new items as they arrive.
class StreamSliverAnimatedListBuilder<T> extends StatefulWidget {
  /// Creates a StreamSliverAnimatedListBuilder.
  ///
  /// [stream] is the stream of data items to display.
  /// [build] is a function to build the widget for each item.
  /// [fallback] is an optional widget to display if the stream has no data initially.
  const StreamSliverAnimatedListBuilder(
      {super.key, required this.stream, required this.build, this.fallback});

  final Stream<T> stream; // The stream of data items.
  final Widget Function(
          BuildContext context, T item, Animation<double> animation)
      build; // The build function for each item.
  final Widget?
      fallback; // The fallback widget if the stream has no data initially.

  @override
  State<StatefulWidget> createState() {
    return _StreamSliverAnimatedListBuilderState<T>();
  }
}

class _StreamSliverAnimatedListBuilderState<T>
    extends State<StreamSliverAnimatedListBuilder<T>> {
  late final GlobalObjectKey<SliverAnimatedListState> _listKey =
      GlobalObjectKey<SliverAnimatedListState>(
          this); // Key for the SliverAnimatedList.

  final List<T> _currentList = []; // List to hold the current items.
  bool _hasData = false; // Flag to check if the stream has emitted any data.

  @override
  void initState() {
    super.initState();

    // Listen to the stream and update the list when new items arrive.
    widget.stream.listen((event) {
      if (_hasData && _listKey.currentState != null) {
        _currentList.add(event);
        _listKey.currentState!.insertItem(0);
      }

      // If this is the first data item, update the state to indicate data is available.
      if (!_hasData) {
        setState(() {
          _hasData = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // If there is no data yet, display the fallback widget.
    if (!_hasData) {
      return SliverToBoxAdapter(child: widget.fallback);
    }

    // Build the SliverAnimatedList with the current list of items.
    return SliverAnimatedList(
      key: _listKey,
      initialItemCount: _currentList.length,
      itemBuilder: (context, index, animation) {
        final item = _currentList[index];
        return widget.build(context, item, animation);
      },
    );
  }
}
