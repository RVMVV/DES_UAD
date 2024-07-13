// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:des_uad/core/constant_finals.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/prestasi_cubit.dart';
import '../../data/models/prestasi/prestasi_mahasiswa_model.dart';

class PrestasiChart extends StatefulWidget {
  @override
  _PrestasiChartState createState() => _PrestasiChartState();
}

class _PrestasiChartState extends State<PrestasiChart> {
  List listPrestasi = [];
  List<BarChartGroupData> lw = [];

  @override
  Widget build(BuildContext context) {
    final prestasiCubit = context.read<PrestasiCubit>();

    return BlocBuilder<PrestasiCubit, PrestasiState>(
      bloc: prestasiCubit..getPrestasiMahasiswa(),
      builder: (context, state) {
        if (state is PrestasiMahasiswaLoaded) {
          listPrestasi.clear();
          lw.clear();

          List<DataPrestasiMhs> listDt = state.data;
          listDt.asMap().forEach((i, value) {
            listPrestasi.add([
              value.tahun,
              value.mhsBerprestasi,
              value.score,
              value.cakupanIntrnsl,
              value.cakupanNsl,
              value.cakupanLkl
            ]);

            lw.addAll([
              makeGroupData(i, double.parse(value.mhsBerprestasi),
                  double.parse(value.score))
            ]);
          });

          return BarChart(
            BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10000,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    // direction: TooltipDirection.top,

                    tooltipRoundedRadius: 8,
                    maxContentWidth: 180,
                    getTooltipColor: (_) => kWhite,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String year = listPrestasi[group.x.toInt()][0];
                      String jmlInternasional =
                          listPrestasi[group.x.toInt()][3];
                      String jmlNasional = listPrestasi[group.x.toInt()][4];
                      String jmlLokal = listPrestasi[group.x.toInt()][5];
                      String jmlSkor = listPrestasi[group.x.toInt()][2];

                      return BarTooltipItem(
                        '$year\n',
                        Styles.kPublicRegularBodyThree
                            .copyWith(color: kLightGrey800),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'Internasional : ' + jmlInternasional + ' \n',
                              style: Styles.kPublicRegularBodyThree
                                  .copyWith(color: kLightGrey500)),
                          TextSpan(
                              text: 'Nasional: ' + jmlNasional + '\n',
                              style: Styles.kPublicRegularBodyThree
                                  .copyWith(color: kLightGrey500)),
                          TextSpan(
                              text: 'Lokal: ' + jmlLokal + '\n',
                              style: Styles.kPublicRegularBodyThree
                                  .copyWith(color: kLightGrey500)),
                          TextSpan(
                              text: 'SKOR: ' + jmlSkor + '\n',
                              style: Styles.kPublicRegularBodyThree
                                  .copyWith(color: kLightGrey500)),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 2500,
                      getTitlesWidget: (value, meta) {
                        return Text(formatLargeNumber(value.toInt()),
                            style: Styles.kPublicRegularBodyThree
                                .copyWith(color: kLightGrey800));
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: lw,
                gridData: const FlGridData(show: false)),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          borderRadius: BorderRadius.zero,
          toY: y1,
          color: kLightBlue,
          width: 25,
        ),
        BarChartRodData(
          borderRadius: BorderRadius.zero,
          toY: y2,
          color: kGreen,
          width: 25,
        ),
      ],
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = Styles.kPublicRegularBodyThree.copyWith(color: klightGrey450);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '2021';
        break;
      case 1:
        text = '2022';
        break;
      case 2:
        text = '2023';
        break;
      case 3:
        text = '2024';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  String formatLargeNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}K';
    }
    return number.toString();
  }
}
