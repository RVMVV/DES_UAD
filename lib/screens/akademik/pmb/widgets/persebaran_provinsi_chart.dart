import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import '../../../../core/constant_finals.dart';
import '../../../../cubit/akademik_cubit.dart';
import '../../../../cubit/mutu_cubit.dart';
import '../../../../cubit/sdm_pre_cubit.dart';
import '../../../../data/data_chart.dart';
import '../../../../data/models/akademik/penerimaan_mahasiswa_baru/persebaran_provinsi.dart';
import '../../../../data/models/persebaran_berdasarkan.dart';
import '../../../../data/models/sdm/sdm_persebaran_prodi_dosen_model.dart';
import '../../../widgets/base_container.dart';
import '../../../widgets/chart/horizontal_bar_chart.dart';

class PersebaranProvinsiChart extends StatefulWidget {
  const PersebaranProvinsiChart({super.key});

  @override
  State<PersebaranProvinsiChart> createState() =>
      _PersebaranProvinsiChartState();
}

class _PersebaranProvinsiChartState extends State<PersebaranProvinsiChart> {
  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: BlocBuilder<AkademikCubit, AkademikState>(
            bloc: akademikCubit..getPersebaranPMB(JenisPMB.persebaran, 2),
            buildWhen: (previous, current) => current is PersebaranPMBState,
            builder: (context, state) {
              print('provinsi');
              print(state);
              if (state is PersebaranPMBLoaded) {
                List<charts.Series<PersebaranBerdasarkan, String>> dataChart = [
                  charts.Series<PersebaranBerdasarkan, String>(
                    id: 'PersebaranBerdasarkan',
                    data: state.datas,
                    domainFn: (datum, index) =>
                        (datum as PersebaranProvinsi).provinsi,
                    measureFn: (datum, index) => datum.getPercent,
                    labelAccessorFn: (datum, index) =>
                        '${(datum as PersebaranProvinsi).provinsi} ${datum.getPercent}% ● ${datum.total}',
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
                        (datum as PersebaranProvinsi).provinsi,
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
