import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class IconRender extends charts.CustomSymbolRenderer {
  IconData iconData;

  IconRender(this.iconData);

  @override
  Widget build(BuildContext context, {Color color, Size size, bool enabled}) {
    return new SizedBox(
        height: 12, width: 12, child: Icon(iconData, color: color, size: 12));
  }
}

class ChartExample extends StatelessWidget {
  List<charts.Series> seriesList;
  bool animate;

  ChartExample(this.seriesList, {this.animate});

  factory ChartExample.withSampleData(data) {
    return new ChartExample(
      _createSampleData(data),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [new charts.SeriesLegend()],
      defaultRenderer: new charts.BarRendererConfig(
          symbolRenderer: new IconRender(Icons.cloud)),
    );
  }

  static List<charts.Series<ChartBarGroup, String>> _createSampleData(data) {
    List<ChartBarGroup> petroldata = [];
    List<ChartBarGroup> dieselData = [];
    List<ChartBarGroup> blenddata = [];

    data.forEach((key, value) {
      petroldata.add(new ChartBarGroup(key, data[key][0].quantity ??= 0));
      dieselData.add(new ChartBarGroup(key, data[key][1].quantity ??= 0));
      blenddata.add(new ChartBarGroup(key, data[key][2].quantity ??= 0));
    });

    return [
      new charts.Series<ChartBarGroup, String>(
          id: "Petrol",
          data: petroldata,
          domainFn: (ChartBarGroup hist, _) => hist.country,
          measureFn: (ChartBarGroup hist, _) => hist.amount),
      new charts.Series<ChartBarGroup, String>(
          id: 'Diesel',
          data: dieselData,
          domainFn: (ChartBarGroup hist, _) => hist.country,
          measureFn: (ChartBarGroup hist, _) => hist.amount),
      new charts.Series<ChartBarGroup, String>(
          id: 'Blend',
          data: blenddata,
          domainFn: (ChartBarGroup hist, _) => hist.country,
          measureFn: (ChartBarGroup hist, _) => hist.amount),
    ];
  }
}

class ChartBarGroup {
  final String country;
  final double amount;

  ChartBarGroup(this.country, this.amount);
}
