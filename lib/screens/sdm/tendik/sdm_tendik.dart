// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:des_uad/data/models/sdm/sdm_pendidikan_tendik_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/sdm_cubit.dart';
import '../../../data/models/sdm/sdm_jabatan_fung_tendik_model.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/card_ratio.dart';
import '../widgets/card_bar_chart.dart';
import '../widgets/card_persebaran.dart';
import '../widgets/card_total_gender.dart';

class SDMTendik extends StatelessWidget {
  const SDMTendik({
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
              bloc: cubit..getJumlahTendik(),
              buildWhen: (previous, current) => current is SdmJumlah,
              builder: (context, state) {
                if (state is SdmJumlahTendikLoaded) {
                  return CardRatio(
                    title: 'Tendik',
                    total: state.data.totalTendik,
                    ratio: state.data.rasioTendik,
                    svgIcon: icBriefcase,
                  );
                }
                //temporary return - nanti diganti sama yang lain
                return CardRatio(
                    title: 'Tendik',
                    total: '--',
                    ratio: '--',
                    svgIcon: icBriefcase);
              },
            ),
            kGap16,
            BlocBuilder<SdmCubit, SdmState>(
              bloc: cubit..getGenderTendik(),
              buildWhen: (previous, current) => current is SdmGender,
              builder: (context, state) {
                if (state is SdmGenderTendikLoaded) {
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
                //temporary return - nanti diganti sama yang lain
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
                const BigCardTitle(title: 'Jabatan Fungsional Tendik'),
                SizedBox(
                  height: 300,
                  child: BlocBuilder<SdmCubit, SdmState>(
                    bloc: cubit..getJabfungTendik(),
                    buildWhen: (previous, current) =>
                        current is SdmJabfungTendik,
                    builder: (context, state) {
                      // print(state);
                      if (state is JabfungTendikLoaded) {
                        final dataJabfungDosen = [
                          charts.Series<DataJabatanFungsionalTendik, String>(
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
                          charts.Series<DataJabatanFungsionalTendik, String>(
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
              title: 'Persebaran Tendik',
            ),
            kGap16,
            BaseContainer.styledBigCard(
              children: [
                const BigCardTitle(title: 'Jabatan Fungsional Tendik'),
                SizedBox(
                  height: 300,
                  child: BlocBuilder<SdmCubit, SdmState>(
                    bloc: cubit..getPendidikanTendik(),
                    buildWhen: (previous, current) =>
                        current is SdmPendidikanTendik,
                    builder: (context, state) {
                      if (state is PendidikanTendikLoaded) {
                        final dataJabfungDosen = [
                          charts.Series<DataPendidikanTendik, String>(
                            id: 'AI',
                            data: state.data,
                            domainFn: (datum, index) => datum.pendTendik,
                            measureFn: (datum, index) => double.parse(
                                datum.persentase.replaceAll('%', '')),
                            labelAccessorFn: (datum, index) =>
                                '${datum.pendTendik}:   ${datum.persentase} ● ${datum.total}',
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
                          charts.Series<DataPendidikanTendik, String>(
                            id: 'AI',
                            domainFn: (datum, index) => datum.pendTendik,
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
            // kGap16,
            // CardBarChart(
            //   title: 'Usia Tendik',
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
