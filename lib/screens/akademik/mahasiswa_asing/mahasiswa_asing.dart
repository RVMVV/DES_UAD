import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/akademik_cubit.dart';
import '../../../data/models/akademik/mahasiswa_asing/persebaran_negara.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/chart/horizontal_bar_chart.dart';
import '../../widgets/chart/line_chart.dart';
import '../../widgets/chart/line_chart_checkbox.dart';
import '../../widgets/rounded_icon_container.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';
import 'mahasiswa_asing_webv.dart';

class MahasiswaAsingPage extends StatelessWidget {
  const MahasiswaAsingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();

    return Scaffold(
      body: BodySubMenuAkademik(
        appBar: const AppBarSubMenuAkademik(
          title: 'Mahasiswa Asing',
        ),
        height: 1050,
        children: [
          BaseContainer.styledBigCard(
            isRow: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Mahasiswa Asing',
                    style: Styles.kPublicRegularBodyTwo,
                  ),
                  BlocBuilder<AkademikCubit, AkademikState>(
                    bloc: akademikCubit..getJumlahMahasiswaAsing(),
                    buildWhen: (previous, current) =>
                        current is JumlahMahasiswaAsing,
                    builder: (context, state) {
                      if (state is JumlahMahasiswaAsingLoaded) {
                        return Text(
                          state.jumlah,
                          style: Styles.kPublicSemiBoldHeadingTwo,
                        );
                      }
                      return Text(
                        '...',
                        style: Styles.kPublicSemiBoldHeadingTwo,
                      );
                    },
                  ),
                ],
              ),
              const RoundedIconContainer(
                side: 64,
                color: kLightGrey100,
                iconColor: kGrey100,
                asset: icFrame,
              ),
            ],
          ),
          kGap16,
          BaseContainer.styledBigCard(
            children: const [
              BigCardTitle(title: 'Tren Mahasiswa Asing'),
              kGap16,
              MahasiswaAsingWebv()
              // LineChartCustomized(),
              // Row(
              //   children: [
              //     LineChartCheckBox(
              //       activeColor: kLightPurple,
              //       year: '2021',
              //       index: 0,
              //     ),
              //     LineChartCheckBox(
              //       activeColor: kPurple,
              //       year: '2022',
              //       index: 1,
              //     ),
              //     LineChartCheckBox(
              //       activeColor: kBlue,
              //       year: '2023',
              //       index: 2,
              //     ),
              //     LineChartCheckBox(
              //       activeColor: kGreen,
              //       year: '2024',
              //       index: 3,
              //     ),
              //   ],
              // ),
            ],
          ),
          kGap16,
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(title: 'Persebaran Negara'),
              SizedBox(
                height: 300,
                child: BlocBuilder<AkademikCubit, AkademikState>(
                  bloc: akademikCubit..getPersebaranNegara(),
                  buildWhen: (previous, current) =>
                      current is PersebaranNegaraMahasiswaAsing,
                  builder: (context, state) {
                    if (state is PersebaranNegaraMahasiswaAsingLoaded) {
                      final dataPersebaranNegara = [
                        charts.Series<PersebaranNegara, String>(
                          id: 'PersebaranNegara',
                          data: state.persebaranNegara,
                          domainFn: (datum, index) => datum.negara,
                          measureFn: (datum, index) => datum.getPercent,
                          labelAccessorFn: (datum, index) =>
                              '${datum.negara} ${datum.getPercent}% ● ${datum.total}',
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
                        charts.Series<PersebaranNegara, String>(
                          id: 'persebaranNegara',
                          domainFn: (datum, index) => datum.negara,
                          measureFn: (datum, index) => 100 - datum.getPercent,
                          data: state.persebaranNegara,
                          labelAccessorFn: (datum, index) => '',
                          colorFn: (datum, index) =>
                              const charts.Color(r: 52, g: 144, b: 252, a: 32),
                        )
                      ];

                      return HorizontalBarLabelChart(dataPersebaranNegara);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
