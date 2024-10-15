import 'package:flutter/material.dart';

import 'amplitude.dart';
import 'amplitude_helpers.dart';
import 'animated_wave_list.dart';

class Waveform extends StatelessWidget {
  const Waveform({super.key, this.amplitudeStream});

  final Stream<Amplitude>? amplitudeStream;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final stream = amplitudeStream ?? createRandomAmplitudeStream();
    return SizedBox(
      width: width,
      height: 100,
      child: AnimatedWaveList(
        stream: stream,
      ),
    );
  }
}
