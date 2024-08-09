import 'package:flutter/material.dart';

import '../../../core/constant_finals.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/chart/pie_chart_legend.dart';
import '../../widgets/chart/pie_chart_with_details.dart';
import '../../widgets/rounded_icon_container.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';

class JurnalUADPage extends StatelessWidget {
  const JurnalUADPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodySubMenuAkademik(
        appBar: const AppBarSubMenuAkademik(
          title: 'Jurnal UAD',
        ),
        // height: MediaQuery.sizeOf(context).height,
        children: [
          kGap16,
          BaseContainer.styledBigCard(
            isRow: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Jurnal',
                    style: Styles.kPublicRegularBodyTwo,
                  ),
                  Text(
                    '64',
                    style: Styles.kPublicSemiBoldHeadingTwo,
                  ),
                ],
              ),
              const RoundedIconContainer(
                side: 64,
                color: kLightGrey100,
                iconColor: kGrey100,
                asset: icClipboard,
              ),
            ],
          ),
          kGap16,
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(
                title: 'Kategori Akreditasi',
              ),
              SizedBox(
                height: 300,
                child: PieChartWithDetails.prodi(
                  title: 'Total Prodi',
                  value: '68',
                ),
              ),
              const PieChartLegend(
                color: kGreen,
                title: 'S1',
                percent: '30%',
                value: '20',
              ),
              kGap12,
              const PieChartLegend(
                color: kBlue,
                title: 'S2',
                percent: '30%',
                value: '20',
              ),
              kGap12,
              const PieChartLegend(
                color: kLightBlue,
                title: 'S3',
                percent: '30%',
                value: '20',
              ),
              kGap12,
              const PieChartLegend(
                color: kYellow,
                title: 'S4',
                percent: '30%',
                value: '20',
              ),
              kGap12,
              const PieChartLegend(
                color: kRed,
                title: 'S5',
                percent: '30%',
                value: '20',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
