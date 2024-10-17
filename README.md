## WaveForm

<img src = "https://raw.githubusercontent.com/agenthesh/waveform/main/assets/waveform-logo.jpg" >

WaveForm is a Flutter package that helps you build animated waveforms in your Flutter app. With the popularity of voice-based chat UIs rising, WaveForm provides an easy and efficient way to visualize audio waveforms. Inspired by WaveSurfer.js, WaveForm offers a range of features to integrate beautiful and functional waveforms into your Flutter applications.

![Demo](https://raw.githubusercontent.com/agenthesh/waveform/main/assets/waveform-example.gif)

## Features

- **Stream-based Waveform Generation**: Create real-time waveforms from a stream of amplitude data.
- **Customizable Bars**: Adjust the appearance of waveform bars, including color and maximum height.
- **Animated Lists**: Use animated lists to smoothly display new waveform data.
- **Flexible Integration**: Easily integrate with other Flutter widgets and packages.

# Important 🚨

Please note that this package does not provide a connection to an audio source (like microphone). I recommend using [record](https://pub.dev/packages/record) to connect this package to a live stream of audio.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  waveform: latest_version
```

Then run `flutter pub get` to install the package.

## Usage

# Basic Example

Below is an example of how to use WaveForm to display an animated waveform:

```dart
import 'package:flutter/material.dart';
import 'package:waveform_flutter/waveform_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('WaveForm Example')),
        body: WaveFormExample(),
      ),
    );
  }
}

class WaveFormExample extends StatefulWidget {
  const WaveFormExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaveFormExampleState createState() => _WaveFormExampleState();
}

class _WaveFormExampleState extends State<WaveFormExample> {
  final Stream<Amplitude> _amplitudeStream = createRandomAmplitudeStream();

  @override
  Widget build(BuildContext context) {
    return AnimatedWaveList(stream: _amplitudeStream);
  }
}
```

# Components

# AnimatedWaveList

Displays an animated list of waveform bars based on a stream of amplitude values.

```dart
const AnimatedWaveList({
  required Stream<Amplitude> stream,
});
```

# WaveformBar

Represents a single bar in the waveform visualisation.

```dart
const WaveFormBar({
  required Amplitude amplitude,
  Animation<double>? animation,
  int maxHeight = 2,
  Color color = Colors.cyan,
});
```

# Helpers

# createRandomAmplitudeStream

Creates a stream of random amplitude values.

```dart
Stream<Amplitude> createRandomAmplitudeStream() {
  return Stream.periodic(
    const Duration(milliseconds: 70),
    (count) => Amplitude(
      current: Random().nextDouble() * 100,
      max: 100,
    ),
  );
}
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on GitHub.

## License

WaveForm is licensed under the MIT License. See the LICENSE file for more details.

## Credits

WaveForm is inspired by WaveSurfer.js.
