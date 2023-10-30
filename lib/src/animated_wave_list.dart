import 'package:flutter/widgets.dart';
import 'package:waveform/src/listmodel.dart';
import 'package:waveform/src/waveform_bar.dart';
import 'package:waveform/waveform_interface.dart';

/// A widget that displays an animated list of waveform bars based on a stream of amplitude values.
class AnimatedWaveList extends StatefulWidget {
  /// Creates an [AnimatedWaveList] widget.
  ///
  /// [stream] is the stream of amplitude values to display.
  const AnimatedWaveList({super.key, required this.stream});

  final Stream<Amplitude> stream; // The stream of amplitude values.

  @override
  State<AnimatedWaveList> createState() => _AnimatedWaveListState();
}

class _AnimatedWaveListState extends State<AnimatedWaveList> {
  final GlobalKey<AnimatedListState> _listKey =
      GlobalKey<AnimatedListState>(); // Key for the AnimatedList.

  late ListModel<Amplitude>
      _list; // Model for managing the list of amplitude values.

  /// Builds a waveform bar widget for the given index and animation.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return WaveFormBar(
      animation: animation,
      amplitude: _list[index],
    );
  }

  /// Builds a waveform bar widget for a removed item with the given animation.
  Widget _buildRemovedItem(
      Amplitude amplitude, BuildContext context, Animation<double> animation) {
    return WaveFormBar(
      animation: animation,
      amplitude: amplitude,
    );
  }

  /// Inserts the next amplitude value into the list model.
  void _insert(Amplitude amplitude) {
    _list.insert(0, amplitude);
  }

  @override
  void initState() {
    super.initState();
    // Initialize the list model with an empty list and the removed item builder.
    _list = ListModel<Amplitude>(
      listKey: _listKey,
      initialItems: <Amplitude>[],
      removedItemBuilder: _buildRemovedItem,
    );

    // Listen to the stream and insert new amplitude values into the list.
    widget.stream.listen((event) {
      if (mounted) _insert(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build the AnimatedList widget.
    return AnimatedList(
      scrollDirection: Axis.horizontal,
      reverse: true,
      key: _listKey,
      initialItemCount: _list.length,
      itemBuilder: _buildItem,
    );
  }
}
