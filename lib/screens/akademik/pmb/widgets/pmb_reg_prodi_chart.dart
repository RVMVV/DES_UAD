import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import '../../../../cubit/akademik_cubit.dart';
import '../../../../data/models/akademik/penerimaan_mahasiswa_baru/persebaran_prodi.dart';
import '../../../../data/models/persebaran_berdasarkan.dart';
import '../../../widgets/chart/horizontal_bar_chart.dart';

class PmbRegProdiChart extends StatefulWidget {
  String fakKode;
  PmbRegProdiChart({Key? key, required this.fakKode}) : super(key: key);

  @override
  State<PmbRegProdiChart> createState() => _PmbRegProdiChartState(this.fakKode);
}

class _PmbRegProdiChartState extends State<PmbRegProdiChart> {
  String fakKode;
  _PmbRegProdiChartState(this.fakKode);
  @override
  Widget build(BuildContext context) {
    final akdCubit = context.read<AkademikCubit>();
    // return Text('data');
    return SizedBox(
      height: 300,
      child: BlocBuilder<AkademikCubit, AkademikState>(
        bloc: akdCubit..getPmbRegulerProdi(fakKode),
        buildWhen: (previous, current) => current is PmbJalurRegState,
        builder: (context, state) {
          // print('page prodi');
          // print(fakKode);
          // print(state);
          if (state is PmbJalurRegLoaded) {
            List<charts.Series<PersebaranBerdasarkan, String>> dataChart = [
              charts.Series<PersebaranBerdasarkan, String>(
                id: 'PersebaranBerdasarkanProdi',
                data: state.datas,
                domainFn: (datum, index) => (datum as PersebaranProdi).prodi,
                measureFn: (datum, index) => datum.getPercent,
                labelAccessorFn: (datum, index) =>
                    '${(datum as PersebaranProdi).prodi} ${datum.getPercent}% ● ${datum.total}',
                insideLabelStyleAccessorFn: (datum, index) =>
                    const charts.TextStyleSpec(
                  color: charts.MaterialPalette.white,
                  fontWeight: 'bold',
                ),
                outsideLabelStyleAccessorFn: (datum, index) =>
                    const charts.TextStyleSpec(
                  color: charts.MaterialPalette.black,
                  fontWeight: 'bold',
                ),
              ),
              charts.Series<PersebaranBerdasarkan, String>(
                id: 'PersebaranBerdasarkan',
                domainFn: (datum, index) => (datum as PersebaranProdi).prodi,
                measureFn: (datum, index) => 100 - datum.getPercent,
                data: state.datas,
                labelAccessorFn: (datum, index) => '',
                colorFn: (datum, index) =>
                    const charts.Color(r: 52, g: 144, b: 252, a: 32),
              )
            ];

            return HorizontalBarLabelChart(dataChart);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
