import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/akademik_cubit.dart';
import '../../../data/models/akademik/keberhasilan_studi/perbandingan_keberhasilan_studi.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/chart/chart_legend.dart';
import '../../widgets/chart/combo_chart.dart';
import '../../widgets/chart/grouped_bar_chart.dart';
import '../../widgets/chart/pie_chart_with_details.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';
import 'widgets/item_studi_mahasiswa.dart';

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
        height: 1425,
        children: [
          // Studi
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
              const Row(
                children: [
                  ItemStudiMahasiswa(
                    title: 'Berhasil',
                    value: '3.872',
                    color: kBlue,
                  ),
                  kGap32,
                  ItemStudiMahasiswa(
                    title: 'Drop Out',
                    value: '1.696',
                    color: kYellow,
                  ),
                ],
              ),
            ],
          ),
          kGap16,
          // Tren
          BaseContainer.styledBigCard(
            children: const [
              BigCardTitle(
                title: 'Tren Keberhasilan Studi',
              ),
              kGap24,
              SizedBox(
                height: 300,
                child: ComboChart(
                  datas: [],
                ),
              ),
            ],
          ),
          kGap16,
          // Perbandingan
          BaseContainer.styledBigCard(
            children: [
              const BigCardTitle(
                title: 'Perbandingan Keberhasilan Studi Dengan Total Mahasiswa',
              ),
              kGap24,
              SizedBox(
                height: 300,
                child: BlocBuilder<AkademikCubit, AkademikState>(
                  bloc: akademikCubit..getPerbandinganKeberhasilanStudi(),
                  buildWhen: (previous, current) =>
                      current is PerbandinganKeberhasilanState,
                  builder: (context, state) {
                    if (state is PerbandinganKeberhasilanLoaded) {
                      final datas = [
                        charts.Series<PerbandinganKeberhasilanStudi, String>(
                          id: 'pks',
                          data: state.datas,
                          domainFn: (datum, index) => datum.tahun,
                          measureFn: (datum, index) => datum.totalMahasiswa,
                          colorFn: (datum, index) =>
                              const charts.Color(r: 32, g: 128, b: 249),
                        ),
                        charts.Series<PerbandinganKeberhasilanStudi, String>(
                          id: 'pks',
                          data: state.datas,
                          domainFn: (datum, index) => datum.tahun,
                          measureFn: (datum, index) => datum.mahasiswaBerhasil,
                          colorFn: (datum, index) =>
                              const charts.Color(r: 0, g: 169, b: 145),
                        ),
                      ];
                      return GroupedBarChart(seriesList: datas);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
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
        ],
      ),
    );
  }
}
