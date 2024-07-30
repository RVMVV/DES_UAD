import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/sdm_cubit.dart';
import '../../../data/models/akademik/penerimaan_mahasiswa_baru/persebaran_prodi.dart';
import '../../../data/models/persebaran_berdasarkan.dart';
import '../../widgets/chart/horizontal_bar_chart.dart';

class SdmPersebaranTendikProdi extends StatelessWidget {
  const SdmPersebaranTendikProdi({super.key, required this.selectedFakultas, required this.fakKode});

  final String selectedFakultas;
  final String fakKode;

  @override
    Widget build(BuildContext context) {
    final SdmCubit cubit = context.read<SdmCubit>();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kGrey100)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedFakultas, //contain selected fakultas
                  style: Styles.kPublicRegularBodyTwo.copyWith(
                    color: kGrey900,
                  ),
                ),
                SvgPicture.asset(icArrowBottom),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: BlocBuilder<SdmCubit, SdmState>(
            bloc: cubit..getPersebaranProdiTendikBerdasarkanFakultas(fakKode),
            buildWhen: (previous, current) => current is SdmPersebaranTendik,
            builder: (context, state) {
              if(state is PersebaranProdiTendikLoading){
                return const Center();
              }
              if (state is PersebaranProdiTendikLoaded) {
                final data = [
                  charts.Series<PersebaranBerdasarkan, String>(
                    id: 'PersebaranBerdasarkanProdi',
                    data: state.datas,
                    domainFn: (datum, index) =>
                        (datum as PersebaranProdi).prodi,
                    measureFn: (datum, index) => datum.getPercent,
                    labelAccessorFn: (datum, index) =>
                        '${(datum as PersebaranProdi).prodi} ${datum.getPercent}% ● ${datum.total}',
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
                  charts.Series<PersebaranBerdasarkan, String>(
                    id: 'PersebaranBerdasarkan',
                    domainFn: (datum, index) =>
                        (datum as PersebaranProdi).prodi,
                    measureFn: (datum, index) => 100 - datum.getPercent,
                    data: state.datas,
                    labelAccessorFn: (datum, index) => '',
                    colorFn: (datum, index) =>
                        const charts.Color(r: 52, g: 144, b: 252, a: 32),
                  )
                ];
                return HorizontalBarLabelChart(data);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

}