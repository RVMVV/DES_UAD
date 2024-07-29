import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/akademik_cubit.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/card_total_registration.dart';
import '../../widgets/chart/line_chart.dart';
import '../../widgets/chart/line_chart_checkbox.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';
import 'widgets/item_data_pmb.dart';
import 'widgets/persebaran_unit_pmb.dart';
import 'widgets/pmb_non_reg.dart';
import 'widgets/pmb_reg.dart';
import 'widgets/pmb_tren_maba_chart.dart';

class PenerimaanMahasiswaBaruPage extends StatelessWidget {
  const PenerimaanMahasiswaBaruPage({super.key});

  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();

    return Scaffold(
      body: BodySubMenuAkademik(
        appBar: const AppBarSubMenuAkademik(
          title: 'PMB',
        ),
        // height: MediaQuery.sizeOf(context).height,
        children: [
          const CardTotalRegistration(),
          kGap16,
          // Data PMB
          BlocBuilder<AkademikCubit, AkademikState>(
            bloc: akademikCubit..getDataPMB(),
            buildWhen: (previous, current) => current is DataPMBState,
            builder: (context, state) {
              if (state is DataPMBLoaded) {
                return BaseContainer.styledBigCard(
                  children: [
                    const BigCardTitle(title: 'Data PMB 2024'),
                    kGap20,
                    ItemDataPMB(
                      asset: icPeople,
                      iconColor: const Color(0xFF3AA0DF),
                      title: 'Total Pendaftar',
                      value: state.data.totalPendaftar,
                    ),
                    kGap20,
                    ItemDataPMB(
                      asset: icProfileTick,
                      iconColor: const Color(0xFF18C07A),
                      title: 'Diterima',
                      value: state.data.diterima,
                    ),
                    kGap20,
                    ItemDataPMB(
                      asset: icTaskSquare,
                      iconColor: const Color(0xFF5CB1C5),
                      title: 'Registrasi',
                      value: state.data.registrasi,
                    ),
                    kGap20,
                    ItemDataPMB(
                      asset: icFrame,
                      iconColor: const Color(0xFF9292EC),
                      title: 'Pendaftar Reguler',
                      value: state.data.pendaftarReguler,
                    ),
                    kGap20,
                    ItemDataPMB(
                      asset: icNoteTwo,
                      iconColor: const Color(0xFFFBA458),
                      title: 'Pendaftar Non Reguler',
                      value: state.data.pendaftarNonReguler,
                    ),
                  ],
                );
              }
              return BaseContainer.styledBigCard(
                children: const [
                  BigCardTitle(title: 'Data PMB 2024'),
                  kGap20,
                  ItemDataPMB(
                    asset: icPeople,
                    iconColor: Color(0xFF3AA0DF),
                    title: 'Total Pendaftar',
                    value: '...',
                  ),
                  kGap20,
                  ItemDataPMB(
                    asset: icProfileTick,
                    iconColor: Color(0xFF18C07A),
                    title: 'Diterima',
                    value: '...',
                  ),
                  kGap20,
                  ItemDataPMB(
                    asset: icTaskSquare,
                    iconColor: Color(0xFF5CB1C5),
                    title: 'Registrasi',
                    value: '...',
                  ),
                  kGap20,
                  ItemDataPMB(
                    asset: icFrame,
                    iconColor: Color(0xFF9292EC),
                    title: 'Pendaftar Reguler',
                    value: '...',
                  ),
                  kGap20,
                  ItemDataPMB(
                    asset: icNoteTwo,
                    iconColor: Color(0xFFFBA458),
                    title: 'Pendaftar Non Reguler',
                    value: '...',
                  ),
                ],
              );
            },
          ),
          kGap16,
          // Line Chart Mahasiswa Baru
          BaseContainer.styledBigCard(
            children: const [
              BigCardTitle(
                title: 'Tren Mahasiswa Baru',
              ),
              kGap16,
              PmbTrenMabaChart(),
              // Container(
              //   child: ,
              // )
              // Container(
              //   child: WebView(
              //     initialUrl:
              //         'https://museum.uad.ac.id/index.php/auth/Auth/testtt/' +
              //             setting.keyApi,
              //     javascriptMode: JavascriptMode.unrestricted,
              //     onWebResourceError: (WebResourceError error) {
              //       Text('');
              //     },
              //   ),
              // )
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
          // Horizontal Bar Chart Persebaran Mahasiswa
          PersebaranUnitPmb(title: 'PMB Berdasarkan Persebaran'),
          kGap16,
          const PmbJalurReg(title: 'PMB Jalur Reguler'),
          kGap16,
          // Horizontal Bar Chart Non Reguler
          const PmbJalurNonReg(title: 'PMB Jalur Non Reguler'),
        ],
      ),
    );
  }
}
