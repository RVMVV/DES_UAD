import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/constant_finals.dart';
import '../../data/models/akademik/penerimaan_mahasiswa_baru/tren_pmb.dart';

class ChartTotalRegistrasi extends StatefulWidget {
  List<Waktu> trens;
  // const ChartTotalRegistrasi({super.key});
  ChartTotalRegistrasi({Key? key, required this.trens}) : super(key: key);

  @override
  State<ChartTotalRegistrasi> createState() =>
      _ChartTotalRegistrasiState(this.trens);
}

class _ChartTotalRegistrasiState extends State<ChartTotalRegistrasi> {
  List<Waktu> trens;
  _ChartTotalRegistrasiState(this.trens);

  List<int> showingTooltipOnSpots = [1, 3, 5];
  List<FlSpot> allSpots = [];

  initState() {
    double amount = 0;
    trens.forEach((element) async {
      allSpots.add(FlSpot(amount, double.parse(element.jumlah)));
      amount++;
    });
  }

  Widget bottomTitleWidgets(String time, TitleMeta meta, double chartWidth) {
    final style = Styles.kPublicBoldBodyFour.copyWith(
      color: kWhite,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(time, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 4,
        color: kWhite,
        belowBarData: BarAreaData(
          show: true,
          color: kWhite.withOpacity(20 / 100),
        ),
        dotData: const FlDotData(show: false),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: LayoutBuilder(builder: (context, constraints) {
        return LineChart(
          LineChartData(
            showingTooltipIndicators: showingTooltipOnSpots.map((index) {
              return ShowingTooltipIndicators(
                [
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ],
              );
            }).toList(),
            lineTouchData: LineTouchData(
              enabled: false,
              handleBuiltInTouches: false,
              touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                if (response == null || response.lineBarSpots == null) {
                  return;
                }
                if (event is FlTapUpEvent) {
                  final spotIndex = response.lineBarSpots!.first.spotIndex;
                  setState(() {
                    if (showingTooltipOnSpots.contains(spotIndex)) {
                      showingTooltipOnSpots.remove(spotIndex);
                    } else {
                      showingTooltipOnSpots.add(spotIndex);
                    }
                  });
                }
              },
              mouseCursorResolver:
                  (FlTouchEvent event, LineTouchResponse? response) {
                if (response == null || response.lineBarSpots == null) {
                  return SystemMouseCursors.basic;
                }
                return SystemMouseCursors.click;
              },
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> spotIndexes) {
                return spotIndexes.map((index) {
                  return TouchedSpotIndicatorData(
                    const FlLine(
                      color: Colors.white,
                    ),
                    FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                        radius: 8,
                        color: kBlue,
                        strokeWidth: 2,
                        strokeColor: kWhite,
                      ),
                    ),
                  );
                }).toList();
              },
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.white,
                tooltipRoundedRadius: 8,
                getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                  return lineBarsSpot.map((lineBarSpot) {
                    return LineTooltipItem(
                      lineBarSpot.y.toStringAsFixed(0),
                      const TextStyle(
                        color: kBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
            lineBarsData: lineBarsData,
            minY: 0,
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                axisNameSize: 24,
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 0,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    print(trens[value.toInt()].jam);
                    String a = trens[value.toInt()].jam;
                    return bottomTitleWidgets(
                      a,
                      meta,
                      constraints.maxWidth,
                    );
                  },
                  reservedSize: 30,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 0,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 0,
                ),
              ),
            ),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
          ),
        );
      }),
    );
  }
}
