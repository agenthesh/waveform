import 'package:flutter/material.dart';
import 'package:waveform_flutter/waveform_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('WaveForm Example')),
          body: WaveFormExample(),
        ),
      );
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
  Widget build(BuildContext context) => AnimatedWaveList(
        stream: _amplitudeStream,
        barBuilder: (animation, amplitude) => WaveFormBar(
          animation: animation,
          amplitude: amplitude,
          color: Colors.red, // override the default of cyan
        ),
      );
}
