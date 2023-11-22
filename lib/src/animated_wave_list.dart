import 'package:flutter/widgets.dart';
import 'package:waveform/src/listmodel.dart';
import 'package:waveform/src/waveform_bar.dart';
import 'package:waveform/waveform_interface.dart';

class AnimatedWaveList extends StatefulWidget {
  const AnimatedWaveList({super.key, required this.stream});

  final Stream<Amplitude> stream;

  @override
  State<AnimatedWaveList> createState() => _AnimatedWaveListState();
}

class _AnimatedWaveListState extends State<AnimatedWaveList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  late ListModel<Amplitude> _list;

  @override
  void initState() {
    super.initState();
    _list = ListModel<Amplitude>(
      listKey: _listKey,
      initialItems: <Amplitude>[],
      removedItemBuilder: _buildRemovedItem,
    );

    widget.stream.listen((event) {
      if (mounted) _insert(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      scrollDirection: Axis.horizontal,
      reverse: true,
      key: _listKey,
      initialItemCount: _list.length,
      itemBuilder: _buildItem,
    );
  }
}
