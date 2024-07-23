// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:des_uad/core/constant_finals.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/akademik_cubit.dart';
import '../../../../data/models/akademik/keberhasilan_studi/perbandingan_keberhasilan_studi.dart';

class keberhasilanStudiChart extends StatefulWidget {
  @override
  _keberhasilanStudiChartState createState() => _keberhasilanStudiChartState();
}

class _keberhasilanStudiChartState extends State<keberhasilanStudiChart> {
  List listAkademik = [];
  List<BarChartGroupData> lw = [];

  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();

    return BlocBuilder<AkademikCubit, AkademikState>(
      bloc: akademikCubit..getPerbandinganKeberhasilanStudi(),
      buildWhen: (previous, current) =>
          current is PerbandinganKeberhasilanState,
      builder: (context, state) {
        if (state is PerbandinganKeberhasilanLoaded) {
          listAkademik.clear();
          lw.clear();

          List<PerbandinganKeberhasilanStudi> listDt = state.datas;
          listDt.asMap().forEach((i, value) {
            listAkademik.add([value.tahun, value.totalMhs, value.mhsBerhasil]);

            lw.addAll([
              makeGroupData(i, double.parse(value.totalMhs.toString()),
                  double.parse(value.mhsBerhasil.toString()))
            ]);
          });

          return BarChart(
            BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10000,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipRoundedRadius: 8,
                    maxContentWidth: 180,
                    getTooltipColor: (_) => kWhite,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String year = listAkademik[group.x.toInt()][0];
                      String totalM = listAkademik[group.x.toInt()][1];
                      String totalL = listAkademik[group.x.toInt()][2];

                      return BarTooltipItem(
                        '$year\n',
                        Styles.kPublicRegularBodyThree
                            .copyWith(color: kLightGrey800),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Jumlah Mahasiswa : ' + totalM + ' \n',
                              style: Styles.kPublicRegularBodyThree
                                  .copyWith(color: kLightGrey500)),
                          TextSpan(
                              text: 'Mahasiswa Berprestasi : ' + totalL + ' \n',
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
    int index = value.toInt();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(listAkademik[index][0], style: style),
    );
  }

  String formatLargeNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}K';
    }
    return number.toString();
  }
}
