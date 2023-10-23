import 'package:flutter/material.dart' show debugPrint;

/// dBFS amplitude
class Amplitude {
  Amplitude({required this.current, required this.max});

  /// Current max amplitude
  final double current;

  /// Top max amplitude
  final double max;
}

extension AmplitudeHelper on Amplitude {
  void toStringA() {
    debugPrint("${current / max}");
  }
}
