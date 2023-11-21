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

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return WaveFormBar(
      animation: animation,
      amplitude: _list[index],
    );
  }

  Widget _buildRemovedItem(
      Amplitude amplitude, BuildContext context, Animation<double> animation) {
    return WaveFormBar(
      animation: animation,
      amplitude: amplitude,
    );
  }

  // Insert the "next item" into the list model.
  void _insert(Amplitude amplitude) {
    _list.insert(0, amplitude);
  }

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
