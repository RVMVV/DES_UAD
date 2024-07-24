import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/akademik_cubit.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/chart/line_chart.dart';
import '../../widgets/chart/line_chart_checkbox.dart';
import '../../widgets/rounded_icon_container.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';
import 'mahasiswa_lokal_chart.dart';

class MahasiswaLokalPage extends StatelessWidget {
  const MahasiswaLokalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();

    return Scaffold(
      body: BodySubMenuAkademik(
        appBar: const AppBarSubMenuAkademik(
          title: 'Mahasiswa Lokal',
        ),
        height: 1250,
        children: [
          BaseContainer.styledBigCard(
            isRow: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Mahasiswa Lokal',
                    style: Styles.kPublicRegularBodyTwo,
                  ),
                  BlocBuilder<AkademikCubit, AkademikState>(
                    bloc: akademikCubit..getJumlahMahasiswaLokal(),
                    buildWhen: (previous, current) =>
                        current is JumlahMahasiswaLokal,
                    builder: (context, state) {
                      if (state is JumlahMahasiswaLokalLoaded) {
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
              BigCardTitle(
                title: 'Tren Mahasiswa Lokal',
              ),
              LineChartCustomized(),
              Row(
                children: [
                  LineChartCheckBox(
                    activeColor: kLightPurple,
                    year: '2021',
                    index: 0,
                  ),
                  LineChartCheckBox(
                    activeColor: kPurple,
                    year: '2022',
                    index: 1,
                  ),
                  LineChartCheckBox(
                    activeColor: kBlue,
                    year: '2023',
                    index: 2,
                  ),
                  LineChartCheckBox(
                    activeColor: kGreen,
                    year: '2024',
                    index: 3,
                  ),
                ],
              ),
            ],
          ),
          kGap16,
          MhsLokalChart(
            title: 'Persebaran PMB',
          ),
          // BaseContainer.styledBigCard(
          //   children: [
          //     const BigCardTitle(
          //       title: 'Persebaran PMB',
          //     ),
          //     kGap28,
          //     BlocBuilder<AkademikCubit, AkademikState>(
          //       builder: (context, state) {
          //         return BaseContainer.activeButtonContainer(
          //           child: Row(
          //             children: [
          //               Expanded(
          //                 child: InkWell(
          //                   onTap: () =>
          //                       akademikCubit.clickActiveButtonMhsLokal(0),
          //                   child: ActiveButton(
          //                       title: 'Fakultas',
          //                       isActive: akademikCubit.indexMhsLokal == 0),
          //                 ),
          //               ),
          //               kGap4,
          //               Expanded(
          //                 child: InkWell(
          //                   onTap: () =>
          //                       akademikCubit.clickActiveButtonMhsLokal(1),
          //                   child: ActiveButton(
          //                       title: 'Prodi',
          //                       isActive: akademikCubit.indexMhsLokal == 1),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //     SizedBox(
          //       height: 300,
          //       child: HorizontalBarLabelChart(dataAkreditasi),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
