import 'dart:math';

import 'package:waveform/src/amplitude.dart';

Stream<Amplitude> createRandomAmplitudeStream() {
  return Stream.periodic(
    const Duration(milliseconds: 70),
    (count) => Amplitude(
      current: Random().nextDouble() * 100,
      max: 100,
    ),
  );
}
