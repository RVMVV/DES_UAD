import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import '../../../../cubit/akademik_cubit.dart';
import '../../../../data/models/akademik/penerimaan_mahasiswa_baru/persebaran_fakultas.dart';
import '../../../../data/models/persebaran_berdasarkan.dart';
import '../../../widgets/chart/horizontal_bar_chart.dart';

class PersebaranFakultasChart extends StatefulWidget {
  const PersebaranFakultasChart({super.key});

  @override
  State<PersebaranFakultasChart> createState() =>
      _PersebaranFakultasChartState();
}

class _PersebaranFakultasChartState extends State<PersebaranFakultasChart> {
  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: BlocBuilder<AkademikCubit, AkademikState>(
            bloc: akademikCubit..getPersebaranPMB(JenisPMB.persebaran, 0),
            buildWhen: (previous, current) => current is PersebaranPMBState,
            builder: (context, state) {
              // print('pfak');
              // print(state);
              if (state is PersebaranPMBLoaded) {
                List<charts.Series<PersebaranBerdasarkan, String>> dataChart = [
                  charts.Series<PersebaranBerdasarkan, String>(
                    id: 'PersebaranBerdasarkan',
                    data: state.datas,
                    domainFn: (datum, index) =>
                        (datum as PersebaranFakultas).fakultas,
                    measureFn: (datum, index) => datum.getPercent,
                    labelAccessorFn: (datum, index) =>
                        '${(datum as PersebaranFakultas).fakultas} ${datum.getPercent}% ● ${datum.total}',
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
                    domainFn: (datum, index) =>
                        (datum as PersebaranFakultas).fakultas,
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
        )
      ],
    );
  }
}
