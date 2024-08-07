import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/akademik_cubit.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/chart/chart_legend.dart';
import '../../widgets/chart/combo_chart.dart';
import '../../widgets/rounded_icon_container.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';
import 'kelulusan_perbandingan_chart.dart';

class KelulusanPage extends StatelessWidget {
  const KelulusanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();

    return Scaffold(
      body: BodySubMenuAkademik(
        appBar: const AppBarSubMenuAkademik(
          title: 'Kelulusan Mahasiswa',
        ),
        // height: 1100,
        children: [
          // AppBar
          BaseContainer.styledBigCard(
            isRow: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Lulus Tepat Waktu 2024',
                    style: Styles.kPublicRegularBodyTwo,
                  ),
                  Text(
                    '320',
                    style: Styles.kPublicSemiBoldHeadingTwo,
                  ),
                ],
              ),
              const RoundedIconContainer(
                  side: 64,
                  color: kLightGrey100,
                  iconColor: kGrey100,
                  asset: icTeacherFill),
            ],
          ),
          kGap12,
          // Combo Chart Kelulusan Tepat Waktu
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(
                title: 'Tren Kelulusan Tepat Waktu',
              ),
              kGap24,
              SizedBox(
                height: 300,
                child: BlocBuilder<AkademikCubit, AkademikState>(
                  bloc: akademikCubit..getTrenKelulusan(),
                  buildWhen: (previous, current) =>
                      current is TrenKelulusanState,
                  builder: (context, state) {
                    if (state is TrenKelulusanLoaded) {
                      return ComboChart(datas: state.datas);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
          kGap16,
          // Grouped Bar Chart

          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(
                title: 'Perbandingan Kelulusan Dengan Total Mahasiswa',
              ),
              kGap24,
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                height: 240,
                child: KelulusanPerbandinganChart(),
              ),
              kGap24,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChartLegend(
                    color: kBlue,
                    title: 'Total Mahasiswa',
                  ),
                  ChartLegend(
                    color: kGreen,
                    title: 'Mahasiswa Lulus',
                  ),
                ],
              ),
            ],
          ),
          kGap16,
        ],
      ),
    );
  }
}
