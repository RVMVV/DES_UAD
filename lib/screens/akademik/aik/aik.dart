import 'package:flutter/material.dart';

import '../../../core/constant_finals.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/chart/horizontal_bar_chart.dart';
import '../../widgets/chart/pie_chart_legend.dart';
import '../../widgets/chart/pie_chart_with_details.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';

class AIKPage extends StatelessWidget {
  const AIKPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodySubMenuAkademik(
        appBar: const AppBarSubMenuAkademik(
          title: 'AIK',
        ),
        // height: 1950,
        children: [
          kGap16,
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(
                title: 'Mahasiswa Lulus TBQ',
              ),
              Text(
                'TA 2023/2024',
                style: Styles.kPublicRegularBodyThree.copyWith(color: kGrey400),
              ),
              SizedBox(
                height: 300,
                child: PieChartWithDetails.prodi(
                  title: 'Total Mahasiswa',
                  value: '29800',
                ),
              ),
              const PieChartLegend(
                color: kGreen,
                title: 'Lulus',
                percent: '50%',
                value: '14.900',
              ),
              kGap12,
              const PieChartLegend(
                color: kRed,
                title: 'Tidak Lulus',
                percent: '50%',
                value: '14.900',
              ),
              kGap12,
              const PieChartLegend(
                color: kBlue,
                title: 'Belum Lulus',
                percent: '50%',
                value: '14.900',
              ),
            ],
          ),
          kGap16,
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(
                title: 'Baca Quran',
              ),
              SizedBox(
                height: 300,
                child: HorizontalBarLabelChart(dataAkreditasi),
              ),
            ],
          ),
          kGap16,
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(
                title: 'Mahasiswa Lulus Baitul Arqam',
              ),
              Text(
                'TA 2023/2024',
                style: Styles.kPublicRegularBodyThree.copyWith(color: kGrey400),
              ),
              SizedBox(
                height: 300,
                child: PieChartWithDetails.prodi(
                  title: 'Total Mahasiswa',
                  value: '29800',
                ),
              ),
              const PieChartLegend(
                color: kGreen,
                title: 'Lulus',
                percent: '50%',
                value: '14.900',
              ),
              kGap12,
              const PieChartLegend(
                color: kYellow,
                title: 'Lulus',
                percent: '50%',
                value: '14.900',
              ),
              kGap12,
              const PieChartLegend(
                color: kBlue,
                title: 'Lulus',
                percent: '50%',
                value: '14.900',
              ),
            ],
          ),
          kGap16,
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(title: 'Baitul Arqam'),
              SizedBox(
                height: 300,
                child: HorizontalBarLabelChart(dataAkreditasi),
              ),
            ],
          ),
          kGap16,
        ],
      ),
    );
  }
}
