import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';

import '../../../core/constant_finals.dart';
import '../../../data/data_chart.dart';
import '../../widgets/base_container.dart';

class HorizontalBarLabelChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;

  final bool animate;

  const HorizontalBarLabelChart(this.seriesList,
      {Key? key, this.animate = true});

  factory HorizontalBarLabelChart.withSampleData() {
    return HorizontalBarLabelChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis:
          const charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }

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

//data temporary
final akreditasis = [
  PendidikanDosen('S1', '32%', '53'),
  // PendidikanDosen('S2', '32%', '53'),
  // PendidikanDosen('S3', '32%', '53'),
  // PendidikanDosen('Profesi', '32%', '53'),
  // PendidikanDosen('Speasialis 1 ', '32%', '53'),
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

// class CardBarChart extends StatelessWidget {
//   final String title;
//   final String pendDosen;
//   final String percent;
//   final String totalValue;

//   const CardBarChart({
//     required this.title,
//     required this.pendDosen,
//     required this.percent,
//     required this.totalValue,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BaseContainer(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: Styles.kPublicSemiBoldBodyOne.copyWith(
//                 color: kGrey900,
//               ),
//             ),
//             SizedBox(
//               height: 300,
//               child: HorizontalBarLabelChart(dataAkreditasi),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
