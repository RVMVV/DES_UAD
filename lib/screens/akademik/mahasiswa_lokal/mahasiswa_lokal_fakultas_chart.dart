import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import '../../../cubit/akademik_cubit.dart';
import '../../../data/models/akademik/penerimaan_mahasiswa_baru/persebaran_fakultas.dart';
import '../../../data/models/persebaran_berdasarkan.dart';
import '../../widgets/chart/horizontal_bar_chart.dart';

class MhsLokalFakultasChart extends StatefulWidget {
  const MhsLokalFakultasChart({super.key});

  @override
  State<MhsLokalFakultasChart> createState() => _MhsLokalFakultasChartState();
}

class _MhsLokalFakultasChartState extends State<MhsLokalFakultasChart> {
  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: BlocBuilder<AkademikCubit, AkademikState>(
            bloc: akademikCubit..getMhsLokalFakultas(),
            buildWhen: (previous, current) => current is MhsLokalState,
            builder: (context, state) {
              if (state is MhsLokalLoaded) {
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
