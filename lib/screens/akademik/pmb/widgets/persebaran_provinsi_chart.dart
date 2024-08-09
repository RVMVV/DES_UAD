import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import '../../../../cubit/akademik_cubit.dart';
import '../../../../data/models/akademik/penerimaan_mahasiswa_baru/persebaran_provinsi.dart';
import '../../../../data/models/persebaran_berdasarkan.dart';
import '../../../widgets/chart/horizontal_bar_chart.dart';

class PersebaranProvinsiChart extends StatefulWidget {
  bool showAllProvinsi;
  PersebaranProvinsiChart({required this.showAllProvinsi, super.key});

  @override
  State<PersebaranProvinsiChart> createState() =>
      _PersebaranProvinsiChartState();
}

class _PersebaranProvinsiChartState extends State<PersebaranProvinsiChart> {
  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            child: BlocBuilder<AkademikCubit, AkademikState>(
              bloc: akademikCubit..getPersebaranPMB(JenisPMB.persebaran, 2),
              buildWhen: (previous, current) => current is PersebaranPMBState,
              builder: (context, state) {
                if (state is PersebaranPMBLoaded) {
                  final dataLength = state.datas.length;
                  final data = widget.showAllProvinsi
                      ? state.datas
                      : state.datas
                          .take(dataLength < 5 ? dataLength : 5)
                          .toList();
                  List<charts.Series<PersebaranBerdasarkan, String>> dataChart =
                      [
                    charts.Series<PersebaranBerdasarkan, String>(
                      id: 'PersebaranBerdasarkan',
                      // data: state.datas,
                      data: data,
                      domainFn: (datum, index) =>
                          (datum as PersebaranProvinsi).provinsi + '${index}',
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
                          (datum as PersebaranProvinsi).provinsi + '${index}',
                      measureFn: (datum, index) => 100 - datum.getPercent,
                      // data: state.datas,
                      data: data,
                      labelAccessorFn: (datum, index) => '',
                      colorFn: (datum, index) =>
                          const charts.Color(r: 52, g: 144, b: 252, a: 32),
                    )
                  ];
                  return SizedBox(
                      height: widget.showAllProvinsi
                          ? state.datas.length * 60
                          : state.datas.length * 10,
                      child: HorizontalBarLabelChart(dataChart));
                  // return HorizontalBarLabelChart(dataChart);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
