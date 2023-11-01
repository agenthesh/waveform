import 'package:flutter/material.dart';
import 'package:waveform/waveform_interface.dart';

/// A widget that represents a single bar in a waveform visualisation.
///
/// The height of the bar is determined by the provided [amplitude], and
/// the bar can optionally be animated with a provided [animation].
class WaveFormBar extends StatelessWidget {
  /// Creates a [WaveFormBar] widget.
  ///
  /// [amplitude] is the amplitude value that determines the height of the bar.
  /// [animation] is an optional animation for the bar.
  /// [maxHeight] is the maximum height multiplier for the bar. Defaults to 2.
  /// [color] is the color of the bar. Defaults to cyan.
  const WaveFormBar({
    super.key,
    required this.amplitude,
    this.animation,
    this.maxHeight = 2,
    this.color = Colors.cyan,
  });

  final Amplitude amplitude; // The amplitude value for the bar height.
  final Animation<double>? animation; // Optional animation for the bar.
  final int maxHeight; // Maximum height multiplier for the bar.
  final Color color; // Color of the bar.

  /// Builds the waveform bar widget.
  ///
  /// The height of the bar is calculated based on the amplitude value,
  /// constrained to a range between 1 and 160, and multiplied by [maxHeight].
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
    // If an animation is provided, wrap the waveform bar in a SizeTransition.
    if (animation != null) {
      return SizeTransition(sizeFactor: animation!, child: _buildWaveFormBar());
    } else {
      // Otherwise, return the waveform bar without animation.
      return _buildWaveFormBar();
    }
  }
}
