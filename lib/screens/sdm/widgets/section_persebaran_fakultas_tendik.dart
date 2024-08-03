import 'package:des_uad/core/constant_finals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import '../../../cubit/sdm_cubit.dart';
import '../../../data/models/akademik/penerimaan_mahasiswa_baru/persebaran_fakultas.dart';
import '../../../data/models/persebaran_berdasarkan.dart';
import '../../widgets/chart/horizontal_bar_chart.dart';

class SdmPersebaranTendikFakultas extends StatelessWidget {
  bool showAllData;
  SdmPersebaranTendikFakultas({super.key, required this.showAllData});

  @override
  Widget build(BuildContext context) {
    final SdmCubit cubit = context.read<SdmCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: BlocBuilder<SdmCubit, SdmState>(
            bloc: cubit..getPersebaranFakultasTendik(),
            buildWhen: (previous, current) => current is SdmPersebaranTendik,
            builder: (context, state) {
              print(state);
              if (state is PersebaranFakultasTendikLoading) {
                return const Center();
              }
              if (state is PersebaranFakultasTendikLoaded) {
                final dataLength = state.datas.length;
                final data = showAllData ? state.datas : state.datas.take(dataLength < 5 ? dataLength : 5).toList();
                List<charts.Series<PersebaranBerdasarkan, String>> dataChart = [
                  charts.Series<PersebaranBerdasarkan, String>(
                    id: 'PersebaranBerdasarkan1',
                    data: data,
                    domainFn: (datum, index) =>
                        (datum as PersebaranFakultas).fakultas + '${index}',
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
                    id: 'PersebaranBerdasarkan2',
                    domainFn: (datum, index) =>
                        (datum as PersebaranFakultas).fakultas + '${index}',
                    measureFn: (datum, index) => 100 - datum.getPercent,
                    data: data,
                    labelAccessorFn: (datum, index) => '',
                    colorFn: (datum, index) =>
                        const charts.Color(r: 52, g: 144, b: 252, a: 32),
                  )
                ];
                return SizedBox(
                  height: data.length * 60.0,
                  child: HorizontalBarLabelChart(dataChart),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        kGap8,
        const Divider(),
      ],
    );
  }
}
