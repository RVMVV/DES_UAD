import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';

import '../../../data/data_chart.dart';
import 'dosen_jabfung_list.dart';

class DosenJabfungChart extends StatefulWidget {
  final List<charts.Series<dynamic, String>> seriesList;

  final bool animate;
  const DosenJabfungChart(this.seriesList, {Key? key, this.animate = true});

  factory DosenJabfungChart.withSampleData() {
    return DosenJabfungChart(
      _createSampleData(),
      animate: false,
    );
  }
  @override
  State<DosenJabfungChart> createState() => _DosenJabfungChartState();

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (OrdinalSales sales, _) =>
            '${sales.year}: \$${sales.sales.toString()}',
      ),
    ];
  }
}

class _DosenJabfungChartState extends State<DosenJabfungChart> {
  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    if (selectedDatum.isNotEmpty) {
      _openDetailPage(
        selectedDatum.first.datum.jabfungKode,
        selectedDatum.first.datum.jabfungTendik,
      );
    }
  }

  void _openDetailPage(String jabfungKode, String jabfungNama) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JabfungDosen(
          jabfungkode: jabfungKode,
          jabfungNama: jabfungNama,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      widget.seriesList,
      animate: widget.animate,
      barGroupingType: charts.BarGroupingType.stacked,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis:
          const charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
      selectionModels: [
        new charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
    );
  }
}

//data temporary
final akreditasis = [
  PendidikanDosen('S1', '32%', '53'),
];

final dataAkreditasi = [
  charts.Series<PendidikanDosen, String>(
    id: 'Akreditasi',
    domainFn: (datum, index) => datum.pendidikanDosen,
    measureFn: (datum, index) =>
        double.parse(datum.persentase.replaceAll('%', '')),
    data: akreditasis,
    // labelAccessorFn: (datum, index) => '${datum.percent}% ● ${datum.value}',
    labelAccessorFn: (datum, index) =>
        '${datum.pendidikanDosen}: ${datum.persentase} ● ${datum.total}',
    insideLabelStyleAccessorFn: (datum, index) => const charts.TextStyleSpec(
      color: charts.MaterialPalette.white,
      fontWeight: 'bold',
    ),
    outsideLabelStyleAccessorFn: (datum, index) => const charts.TextStyleSpec(
      color: charts.MaterialPalette.black,
      fontWeight: 'bold',
    ),
  ),
  charts.Series<PendidikanDosen, String>(
    id: 'Akreditasi',
    domainFn: (datum, index) => datum.pendidikanDosen,
    measureFn: (datum, index) =>
        double.parse(datum.persentase.replaceAll('', '')),
    data: akreditasis,
    labelAccessorFn: (datum, index) => '',
  )
];
