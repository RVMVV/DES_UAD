import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant_finals.dart';
import '../../cubit/prestasi_cubit.dart';
import '../widgets/active_button.dart';
import '../widgets/base_container.dart';
import '../widgets/big_card_title.dart';
import '../widgets/chart/chart_legend.dart';
import '../widgets/chart/horizontal_bar_chart.dart';
import '../widgets/chart_prestasi.dart';

class PrestasiPage extends StatelessWidget {
  const PrestasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prestasiCubit = context.read<PrestasiCubit>();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            centerTitle: false,
            title: Text(
              'Prestasi',
              style:
                  Styles.kPublicSemiBoldHeadingThree.copyWith(color: kGrey900),
            ),
            snap: false,
            floating: true,
            pinned: false,
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              BaseContainer.styledBigCard(
                children: [
                  const BigCardTitle(title: 'Prestasi Mahasiswa'),
                  kGap24,
                  SizedBox(
                    height: 300,
                    child: PrestasiChart(),
                  ),
                  kGap24,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChartLegend(color: kBlue, title: 'Mahasiswa Berprestasi'),
                      ChartLegend(color: kGreen, title: 'Skor'),
                    ],
                  ),
                ],
              ),
              kGap24,
              // BaseContainer.styledBigCard(
              //   children: [
              //     const BigCardTitle(title: 'Cakupan Prestasi'),
              //     kGap28,
              //     BaseContainer.activeButtonContainer(
              //       child: BlocBuilder<PrestasiCubit, PrestasiState>(
              //         builder: (context, state) {
              //           return Row(
              //             children: [
              //               Expanded(
              //                 child: InkWell(
              //                   onTap: () =>
              //                       prestasiCubit.clickCakupanPrestasiButton(),
              //                   child: ActiveButton(
              //                     title: 'Nasional',
              //                     isActive: prestasiCubit.isNasional,
              //                   ),
              //                 ),
              //               ),
              //               kGap8,
              //               Expanded(
              //                 child: InkWell(
              //                   onTap: () =>
              //                       prestasiCubit.clickCakupanPrestasiButton(
              //                           isActive: false),
              //                   child: ActiveButton(
              //                     title: 'Internasional',
              //                     isActive: !prestasiCubit.isNasional,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           );
              //         },
              //       ),
              //     ),
              //     SizedBox(
              //       height: 300,
              //       child: HorizontalBarLabelChart(dataAkreditasi),
              //     ),
              //   ],
              // ),
              // kGap80,
            ],
          ),
        ),
      ),
    );
  }
}
