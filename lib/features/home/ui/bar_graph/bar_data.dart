import 'package:project_cdm/features/home/ui/bar_graph/individual_bar.dart';

class BarData {
  final double monValue;
  final double tueValue;
  final double wedValue;
  final double thurValue;
  final double friValue;
  final double satValue;
  final double sunValue;

  BarData({
    required this.sunValue,
    required this.monValue,
    required this.tueValue,
    required this.wedValue,
    required this.thurValue,
    required this.friValue,
    required this.satValue,
  });

  List<IndividualBar> barData = [];

  void initilizeBarData() {
    barData = [
      IndividualBar(x: 0, y: monValue),
      IndividualBar(x: 1, y: tueValue),
      IndividualBar(x: 2, y: wedValue),
      IndividualBar(x: 3, y: thurValue),
      IndividualBar(x: 4, y: friValue),
      IndividualBar(x: 5, y: satValue),
      IndividualBar(x: 6, y: sunValue),
    ];
  }
}
