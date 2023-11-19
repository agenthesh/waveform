import 'package:flutter/widgets.dart';

class StreamSliverAnimatedListBuilder<T> extends StatefulWidget {
  const StreamSliverAnimatedListBuilder(
      {super.key, required this.stream, required this.build, this.fallback});

  final Stream<T> stream;
  final Widget Function(
      BuildContext context, T item, Animation<double> animation) build;
  final Widget? fallback;

  @override
  State<StatefulWidget> createState() {
    return _StreamSliverAnimatedListBuilderState<T>();
  }
}

class _StreamSliverAnimatedListBuilderState<T>
    extends State<StreamSliverAnimatedListBuilder<T>> {
  late final GlobalObjectKey<SliverAnimatedListState> _listKey =
      GlobalObjectKey<SliverAnimatedListState>(this);

  final List<T> _currentList = [];
  bool _hasData = false;

  @override
  void initState() {
    super.initState();

    widget.stream.listen((event) {
      if (_hasData && _listKey.currentState != null) {
        _currentList.add(event);
        _listKey.currentState!.insertItem(0);
      }

      if (!_hasData) {
        setState(() {
          _hasData = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasData) {
      return SliverToBoxAdapter(child: widget.fallback);
    }

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
