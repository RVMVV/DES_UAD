import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/mutu_cubit.dart';
import '../../../data/models/mutu/persebaran_akreditasi_internasional.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/chart/horizontal_bar_chart.dart';
import '../../widgets/chart/pie_chart_with_details.dart';
import '../../widgets/rounded_icon_container.dart';
import 'bottom_modal_akreditasi_prodi.dart';
import 'pie_chart_akreditasi_prodi.dart';

class AkreditasiSection extends StatelessWidget {
  const AkreditasiSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const colors = [kGreen, kBlue, kPurple, kYellow, kPink];
    final mutuCubit = context.read<MutuCubit>();

    return Column(
      children: [
        // Total Prodi
        BaseContainer.styledBigCard(
          isRow: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Prodi',
                  style: Styles.kPublicRegularBodyTwo.copyWith(color: kGrey600),
                ),
                BlocBuilder<MutuCubit, MutuState>(
                  bloc: mutuCubit..getTotalProdi(),
                  buildWhen: (previous, current) => current is TotalProdiState,
                  builder: (context, state) {
                    if (state is TotalProdiLoaded) {
                      return Text(
                        state.data,
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
                asset: icAward),
          ],
        ),
        kGap16,
        // Pie Chart
        BaseContainer.styledBigCard(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BigCardTitle(title: 'Akreditasi Prodi'),
                RoundedIconContainer(
                    side: 32,
                    color: kBlue.withOpacity(.12),
                    iconColor: kBlue,
                    asset: icNoteTwo),
              ],
            ),
            SizedBox(
              height: 300,
              child: BlocBuilder<MutuCubit, MutuState>(
                bloc: mutuCubit..getAkreditasiProdi(),
                buildWhen: (previous, current) =>
                    current is PersebaranAkreditasiProdiState,
                builder: (context, state) {
                  if (state is PersebaranAkreditasiProdiLoaded) {
                    final totalProdi = state.datas
                        .map((e) => int.parse(e.total))
                        .reduce((value, element) => value + element);
                    List<PieChartSectionData> getData() {
                      return List.generate(
                        state.datas.length,
                        (index) => PieChartSectionData(
                          showTitle: false,
                          color: colors[index],
                          value:
                              double.tryParse(state.datas[index].total) ?? 0.0,
                          radius: 15,
                        ),
                      );
                    }

                    return PieChartWithDetails(
                      title: 'Total Prodi',
                      value: '$totalProdi',
                      sections: getData(),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            BlocBuilder<MutuCubit, MutuState>(
              buildWhen: (previous, current) =>
                  current is PersebaranAkreditasiProdiState,
              builder: (context, state) {
                if (state is PersebaranAkreditasiProdiLoaded) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => PieChartAkreditasiProdi(
                      color: colors[index],
                      title: state.datas[index].akreditasi,
                      percent: state.datas[index].persentase,
                      value: state.datas[index].total,
                    ),
                    separatorBuilder: (context, index) => kGap12,
                    itemCount: state.datas.length,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        kGap16,
        // Small Card
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return BottomModalAkreditasiProdi(
                            akre: 'Akreditasi Internasional');
                      });
                },
                child: BaseContainer(
                  height: 130,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const RoundedIconContainer(
                              side: 32,
                              color: kGrey100,
                              iconColor: kGrey900,
                              asset: icMedal),
                          kGap8,
                          Text(
                            'Akreditasi \nInternasional',
                            style: Styles.kPublicMediumBodyThree
                                .copyWith(color: kGrey600),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '46%',
                            style: Styles.kPublicSemiBoldHeadingTwo
                                .copyWith(color: kGrey900),
                          ),
                          SvgPicture.asset(
                            icRightArrow,
                            width: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            kGap12,
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return BottomModalAkreditasiProdi(
                            akre: 'Sertifikasi Internasional');
                      });
                },
                child: BaseContainer(
                  height: 130,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const RoundedIconContainer(
                              side: 32,
                              color: kGrey100,
                              iconColor: kGrey900,
                              asset: icMedalStar),
                          kGap8,
                          Text(
                            'Sertifikasi \nInternasional',
                            style: Styles.kPublicMediumBodyThree
                                .copyWith(color: kGrey600),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '32%',
                            style: Styles.kPublicSemiBoldHeadingTwo
                                .copyWith(color: kGrey900),
                          ),
                          SvgPicture.asset(
                            icRightArrow,
                            width: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        kGap12,
        // Horizontal Bar Chart
        BaseContainer.styledBigCard(
          children: [
            const BigCardTitle(title: 'Akreditasi Internasional'),
            SizedBox(
              height: 300,
              child: BlocBuilder<MutuCubit, MutuState>(
                bloc: mutuCubit..getAkreditasiInternasional(),
                buildWhen: (previous, current) =>
                    current is PersebaranAkreditasiInternasionalState,
                builder: (context, state) {
                  if (state is PersebaranAkreditasiInternasionalLoaded) {
                    final dataAkreditasiInternasional = [
                      charts.Series<PersebaranAkreditasiInternasional, String>(
                        id: 'AI',
                        data: state.datas,
                        domainFn: (datum, index) => datum.prodi,
                        measureFn: (datum, index) => datum.getPercent,
                        labelAccessorFn: (datum, index) =>
                            '${datum.prodi} ${datum.persentase} ● ${datum.total}',
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
                      charts.Series<PersebaranAkreditasiInternasional, String>(
                        id: 'AI',
                        domainFn: (datum, index) => datum.prodi,
                        measureFn: (datum, index) => 100 - datum.getPercent,
                        data: state.datas,
                        labelAccessorFn: (datum, index) => '',
                        colorFn: (datum, index) =>
                            const charts.Color(r: 52, g: 144, b: 252, a: 32),
                      )
                    ];
                    return HorizontalBarLabelChart(dataAkreditasiInternasional);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
