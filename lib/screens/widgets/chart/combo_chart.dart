import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constant_finals.dart';
import '../../../data/models/akademik/kelulusan/tren_kelulusan.dart';

class ComboChart extends StatelessWidget {
  const ComboChart({
    super.key,
    required this.datas,
  });

  final List<TrenKelulusan> datas;

  @override
  Widget build(BuildContext context) {
    final ordinalData = List.generate(
        datas.length,
        (index) => OrdinalData(
            domain: datas[index].tahun, measure: datas[index].percent));

    final ordinalGroup = [
      OrdinalGroup(
        id: '1',
        chartType: ChartType.bar,
        color: kBlue,
        data: ordinalData,
      ),
      OrdinalGroup(
        id: '2',
        chartType: ChartType.line,
        color: kPink,
        data: ordinalData,
      ),
      OrdinalGroup(
        id: '3',
        chartType: ChartType.scatterPlot,
        color: kGrey800,
        data: ordinalData,
      ),
    ];

    return DChartComboO(
        barLabelDecorator: BarLabelDecorator(),
        groupList: ordinalGroup,
        animate: true,
        barLabelValue: (group, OrdinalData, index) {
          return '${OrdinalData.measure} %';
        });
  }
}
