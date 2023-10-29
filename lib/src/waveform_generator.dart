import 'package:flutter/widgets.dart';
import 'package:waveform/src/list_helpers.dart';
import 'package:waveform/src/waveform_bar.dart';
import 'package:waveform/waveform_interface.dart';

class WaveFormGenerator extends StatelessWidget {
  const WaveFormGenerator({
    super.key,
    required this.amplitude,
    required this.maxHeight,
  });

  final List<double> amplitude;
  final int maxHeight;

  //width of each waveFormbar is 4 + 4
  //max amplitude should be the height.
  //then generate a list of waveformbar that generates width/8 bars
  //see how many elements there are in the list of amplitude.
  //split it by the number of bars
  //average out the amplitude for that bar and apply it to the height.

  static const int barWidthWithSpacing = 8;

  int getNumberOfWaveFormBars({required double width}) {
    return width ~/ barWidthWithSpacing;
  }
  //how many bars will show up in the UI

  List<int> getAverageAmplitudeForEachBar({required double width}) {
    final lengthOfData = amplitude.length;

    final pointsToAverage =
        (lengthOfData / getNumberOfWaveFormBars(width: width)).floor();
    //how many points you should average for each bar.
    try {
      return amplitude.averagedList(pointsToAverage: pointsToAverage);
    } catch (e) {
      return amplitude.map((e) => e.toInt()).toList();
    }
  }

  List<Amplitude> convertToAmplitude({required double width}) {
    final adjustedAmplitudeData = getAverageAmplitudeForEachBar(width: width);

    final maxAmplitude = adjustedAmplitudeData.findMax();

    final list = adjustedAmplitudeData
        .map(
          (e) => Amplitude(
            current: e.toDouble(),
            max: maxAmplitude.toDouble(),
          ),
        )
        .take(getNumberOfWaveFormBars(width: width))
        //the averagedList function might return more elements than the bars
        //we can accomodate in the width because we use a floor.

        .toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final adjustedAmplitudeData =
          convertToAmplitude(width: constraints.maxWidth);
      return Row(
        children: adjustedAmplitudeData
            .map<Widget>(
              (e) => WaveFormBar(
                amplitude: e,
                maxHeight: 2,
              ),
            )
            .toList(),
      );
    });
  }
}
