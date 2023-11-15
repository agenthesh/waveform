import 'package:flutter/material.dart';
import 'package:waveform/waveform_interface.dart';

class WaveFormBar extends StatelessWidget {
  const WaveFormBar({
    super.key,
    required this.amplitude,
    this.animation,
    this.maxHeight = 2,
    this.color = Colors.cyan,
  });

  final Amplitude amplitude;
  final Animation<double>? animation;
  final int maxHeight;
  final Color color;

  Widget _buildWaveFormBar() {
    return Container(
      width: 4,
      height: (160 / amplitude.current.abs().clamp(1, 160)) * maxHeight,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (animation != null) {
      return SizeTransition(sizeFactor: animation!, child: _buildWaveFormBar());
    } else {
      return _buildWaveFormBar();
    }
  }
}
