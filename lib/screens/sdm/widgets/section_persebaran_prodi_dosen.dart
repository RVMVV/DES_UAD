import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import '../../../core/constant_finals.dart';
import '../../../cubit/sdm_cubit.dart';
import '../../../data/models/sdm/sdm_persebaran_prodi_dosen_model.dart';
import '../../widgets/chart/horizontal_bar_chart.dart';

class SdmPersebaranProdiDosen extends StatelessWidget {
  const SdmPersebaranProdiDosen({
    super.key,
    required this.selectedFakultas,
  });

  final String selectedFakultas;

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
            bloc: cubit..getPersebaranProdiDosen(),
            buildWhen: (previous, current) => current is SdmProdiDosen,
            builder: (context, state) {
              print(state);
              if (state is PersebaranProdiDosenLoaded) {
                final dataPersebaranProdiDosen = [
                  charts.Series<DataPersebaranProdiDosen, String>(
                    id: 'AI',
                    data: state.data,
                    domainFn: (datum, index) => datum.prodi,
                    measureFn: (datum, index) =>
                        double.parse(datum.persentase.replaceAll('%', '')),
                    labelAccessorFn: (datum, index) =>
                        '${datum.prodi}:   ${datum.persentase} ● ${datum.total}',
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
                  charts.Series<DataPersebaranProdiDosen, String>(
                    id: 'AI',
                    domainFn: (datum, index) => datum.prodi,
                    measureFn: (datum, index) =>
                        100 -
                        double.parse(datum.persentase.replaceAll('%', '')),
                    data: state.data,
                    labelAccessorFn: (datum, index) => '',
                    colorFn: (datum, index) =>
                        const charts.Color(r: 52, g: 144, b: 252, a: 32),
                  )
                ];
                return HorizontalBarLabelChart(dataPersebaranProdiDosen);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
