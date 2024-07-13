// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/sdm_cubit.dart';
import '../../../data/models/sdm/sdm_jabatan_fung_dosen_model.dart';
import '../../../data/models/sdm/sdm_pendidikan_dosen_model.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/card_ratio.dart';
import '../widgets/card_bar_chart.dart';
import '../widgets/card_persebaran.dart';
import '../widgets/card_total_gender.dart';

class SDMDosen extends StatelessWidget {
  const SDMDosen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SdmCubit cubit = context.read<SdmCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<SdmCubit, SdmState>(
              bloc: cubit..getJumlahDosen(),
              buildWhen: (previous, current) => current is SdmJumlah,
              builder: (context, state) {
                // print(state);
                if (state is SdmJumlahDosenLoaded) {
                  return CardRatio(
                    title: 'Dosen',
                    total: state.data.totalDosen,
                    ratio: state.data.rasioDosen,
                    svgIcon: icProfileTwoUser,
                  );
                }
                //temporary return - nanti diganti pake circular
                return CardRatio(
                    title: 'Dosen',
                    total: '--',
                    ratio: '--',
                    svgIcon: icBriefcase);
              },
            ),
            kGap16,
            BlocBuilder<SdmCubit, SdmState>(
              bloc: cubit..getGenderDosen(),
              buildWhen: (previous, current) => current is SdmGender,
              builder: (context, state) {
                // print(state);
                if (state is SdmGenderDosenLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TotalGender(
                        icon: icManGender,
                        title: 'Laki-laki',
                        value: state.data.lakiLaki,
                        color: kLightBlue,
                      ),
                      kGap12,
                      TotalGender(
                        icon: icWomanGender,
                        title: 'Perempuan',
                        value: state.data.perempuan,
                        color: kRed,
                      ),
                    ],
                  );
                }
                //temporary return - nanti diganti pake circular
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TotalGender(
                      icon: icManGender,
                      title: 'Laki-laki',
                      value: '--',
                      color: kLightBlue,
                    ),
                    kGap12,
                    TotalGender(
                      icon: icWomanGender,
                      title: 'Perempuan',
                      value: '--',
                      color: kRed,
                    ),
                  ],
                );
              },
            ),
            kGap16,
            BaseContainer.styledBigCard(
              children: [
                const BigCardTitle(title: 'Jabatan Fungsional Dosen'),
                SizedBox(
                  height: 300,
                  child: BlocBuilder<SdmCubit, SdmState>(
                    bloc: cubit..getJabfungDosen(),
                    buildWhen: (previous, current) =>
                        current is SdmJabfungDosen,
                    builder: (context, state) {
                      // print(state);
                      if (state is JabfungDosenLoaded) {
                        final dataJabfungDosen = [
                          charts.Series<DataJabatanFungsionalDosen, String>(
                            id: 'AI',
                            data: state.data,
                            domainFn: (datum, index) => datum.jabfungTendik,
                            measureFn: (datum, index) => double.parse(
                                datum.persentase.replaceAll('%', '')),
                            labelAccessorFn: (datum, index) =>
                                '${datum.jabfungTendik}:   ${datum.persentase} ● ${datum.total}',
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
                          charts.Series<DataJabatanFungsionalDosen, String>(
                            id: 'AI',
                            domainFn: (datum, index) => datum.jabfungTendik,
                            measureFn: (datum, index) =>
                                100 -
                                double.parse(
                                    datum.persentase.replaceAll('%', '')),
                            data: state.data,
                            labelAccessorFn: (datum, index) => '',
                            colorFn: (datum, index) => const charts.Color(
                                r: 52, g: 144, b: 252, a: 32),
                          )
                        ];
                        return HorizontalBarLabelChart(dataJabfungDosen);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
            kGap16,
            Persebaran(
              title: 'Persebaran Dosen',
            ),
            kGap16,
            BaseContainer.styledBigCard(
              children: [
                const BigCardTitle(title: 'Pendidikan Dosen'),
                SizedBox(
                  height: 300,
                  child: BlocBuilder<SdmCubit, SdmState>(
                    bloc: cubit..getPendidikanDosen(),
                    buildWhen: (previous, current) =>
                        current is SdmPendidikanDosen,
                    builder: (context, state) {
                      // print(state);
                      if (state is PendidikanDosenLoaded) {
                        final dataPendidikanDosen = [
                          charts.Series<DataPendidikanDosen, String>(
                            id: 'AI',
                            data: state.data,
                            domainFn: (datum, index) => datum.pendDosen,
                            measureFn: (datum, index) => double.parse(
                                datum.persentase.replaceAll('%', '')),
                            labelAccessorFn: (datum, index) =>
                                '${datum.pendDosen}:   ${datum.persentase} ● ${datum.total}',
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
                          charts.Series<DataPendidikanDosen, String>(
                            id: 'AI',
                            domainFn: (datum, index) => datum.pendDosen,
                            measureFn: (datum, index) =>
                                100 -
                                double.parse(
                                    datum.persentase.replaceAll('%', '')),
                            data: state.data,
                            labelAccessorFn: (datum, index) => '',
                            colorFn: (datum, index) => const charts.Color(
                                r: 52, g: 144, b: 252, a: 32),
                          )
                        ];
                        return HorizontalBarLabelChart(dataPendidikanDosen);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
            kGap16,
            // kGap16,
            // CardBarChart(
            //   title: 'Usia Dosen',
            // ),
            // kGap16,
            // CardBarChart(
            //   title: 'Sertifikasi',
            // ),
            kGap70,
          ],
        ),
      ),
    );
  }
}
