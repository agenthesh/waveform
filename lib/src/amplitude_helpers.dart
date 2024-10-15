import 'dart:math';

import 'amplitude.dart';

/// Creates a stream of random amplitude values.
///
/// The stream emits an `Amplitude` object every 70 milliseconds. The `current`
/// amplitude is a random value between 0 and 100, and the `max` amplitude is fixed at 100.
///
/// Returns:
///   A `Stream<Amplitude>` that emits random amplitude values.
Stream<Amplitude> createRandomAmplitudeStream() {
  // Create a periodic stream that emits values every 70 milliseconds.
  return Stream.periodic(
    const Duration(
        milliseconds: 70), // The interval duration between emissions.
    (count) => Amplitude(
      current: Random().nextDouble() *
          100, // Generate a random current amplitude between 0 and 100.
      max: 100, // Set the maximum amplitude to 100.
    ),
  );
}
