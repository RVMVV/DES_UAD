import 'package:des_uad/core/constant_finals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import '../../../cubit/sdm_pre_cubit.dart';
import '../../../data/models/akademik/penerimaan_mahasiswa_baru/persebaran_fakultas.dart';
import '../../../data/models/persebaran_berdasarkan.dart';
import '../../widgets/chart/horizontal_bar_chart.dart';

class SdmPersebaranDosenFakultas extends StatelessWidget {
  final bool showAllData;

  SdmPersebaranDosenFakultas({
    required this.showAllData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SdmPreCubit cubit = context.read<SdmPreCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: BlocBuilder<SdmPreCubit, SdmPreState>(
            bloc: cubit..getPersebaranFakultasDosen(),
            buildWhen: (previous, current) => current is PersebaranFakultasDosen,
            builder: (context, state) {
              if (state is PersebaranFakultasDosenLoaded) {
                final dataLength = state.datas.length;
                final data = showAllData ? state.datas : state.datas.take(dataLength < 5 ? dataLength : 5).toList();

                List<charts.Series<PersebaranBerdasarkan, String>> dataChart = [
                  charts.Series<PersebaranBerdasarkan, String>(
                    id: 'PersebaranBerdasarkan1',
                    data: data,
                    domainFn: (datum, index) => (datum as PersebaranFakultas).fakultas + '${index}',
                    measureFn: (datum, index) => datum.getPercent,
                    labelAccessorFn: (datum, index) => '${(datum as PersebaranFakultas).fakultas} ${datum.getPercent}% ● ${datum.total}',
                    insideLabelStyleAccessorFn: (datum, index) => const charts.TextStyleSpec(
                      color: charts.MaterialPalette.white,
                      fontWeight: 'bold',
                    ),
                    outsideLabelStyleAccessorFn: (datum, index) => const charts.TextStyleSpec(
                      color: charts.MaterialPalette.black,
                      fontWeight: 'bold',
                    ),
                  ),
                  charts.Series<PersebaranBerdasarkan, String>(
                    id: 'PersebaranBerdasarkan2',
                    domainFn: (datum, index) => (datum as PersebaranFakultas).fakultas + '${index}',
                    measureFn: (datum, index) => 100 - datum.getPercent,
                    data: data,
                    labelAccessorFn: (datum, index) => '',
                    colorFn: (datum, index) => const charts.Color(r: 52, g: 144, b: 252, a: 32),
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
