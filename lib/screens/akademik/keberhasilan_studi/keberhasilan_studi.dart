import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/akademik_cubit.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/chart/chart_legend.dart';
import '../../widgets/chart/combo_chart.dart';
import '../../widgets/chart/pie_chart_with_details.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';
import 'widgets/item_studi_mahasiswa.dart';
import 'widgets/keberhasilan_studi_chart.dart';

class KeberhasilanStudiPage extends StatelessWidget {
  const KeberhasilanStudiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();
    return Scaffold(
      body: BodySubMenuAkademik(
        appBar: const AppBarSubMenuAkademik(
          title: 'Keberhasilan Studi',
        ),
        // height: 1600,
        children: [
          // Studi
          kGap16,
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(
                title: 'Studi Mahasiswa',
              ),
              Text(
                'TA 2023/2024',
                style: Styles.kPublicRegularBodyThree.copyWith(color: kGrey400),
              ),
              SizedBox(
                height: 300,
                child: BlocBuilder<AkademikCubit, AkademikState>(
                  bloc: akademikCubit..getStudiMahasiswa(),
                  buildWhen: (previous, current) =>
                      current is StudiMahasiswaState,
                  builder: (context, state) {
                    if (state is StudiMahasiswaLoaded) {
                      final values = [
                        state.data.getBerhasil,
                        state.data.getDropOut
                      ];
                      const colors = [kBlue, kYellow];
                      final sections = List.generate(
                          values.length,
                          (index) => PieChartSectionData(
                              color: colors[index],
                              radius: 15,
                              showTitle: false,
                              value: values[index]));
                      return PieChartWithDetails(
                          title: 'Total Mahasiswa',
                          value: state.data.totalMhs,
                          sections: sections);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              BlocBuilder<AkademikCubit, AkademikState>(
                bloc: akademikCubit..getStudiMahasiswa(),
                buildWhen: (previous, current) =>
                    current is StudiMahasiswaState,
                builder: (context, state) {
                  if (state is StudiMahasiswaLoaded) {
                    return Row(
                      children: [
                        ItemStudiMahasiswa(
                          title: 'Berhasil',
                          value: state.data.getBerhasil.toInt().toString(),
                          color: kBlue,
                        ),
                        kGap32,
                        ItemStudiMahasiswa(
                          title: 'Drop Out',
                          value: state.data.getDropOut.toInt().toString(),
                          color: kYellow,
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      ItemStudiMahasiswa(
                        title: 'Berhasil',
                        value: '...',
                        color: kBlue,
                      ),
                      kGap32,
                      ItemStudiMahasiswa(
                        title: 'Drop Out',
                        value: '...',
                        color: kYellow,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          kGap16,
          // Tren
          // BaseContainer.styledBigCard(
          //   children: const [
          //     BigCardTitle(
          //       title: 'Tren Keberhasilan Studi',
          //     ),
          //     kGap24,
          //     SizedBox(
          //       height: 300,
          //       child: ComboChart(
          //         datas: [],
          //       ),
          //     ),
          //   ],
          // ),
          // kGap16,
          // Perbandingan
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(
                title: 'Perbandingan Keberhasilan Studi Dengan Total Mahasiswa',
              ),
              kGap24,
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                height: 300,
                child: keberhasilanStudiChart(),
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
                    title: 'Mahasiswa Berhasil',
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
