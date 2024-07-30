import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/mutu_cubit.dart';
import '../mutu/widgets/pie_chart_akreditasi_prodi.dart';
import 'big_card_title.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constant_finals.dart';
import 'base_container.dart';
import 'chart/pie_chart_legend.dart';
import 'chart/pie_chart_with_details.dart';

class CardAkreditasiProdi extends StatelessWidget {
  const CardAkreditasiProdi({super.key});

  @override
  Widget build(BuildContext context) {
    const colors = [kGreen, kBlue, kPurple, kYellow, kPink];
    final mutuCubit = context.read<MutuCubit>();
    return BaseContainer.styledBigCard(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BigCardTitle(title: 'Akreditasi Prodi'),
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
                      value: double.tryParse(state.datas[index].total) ?? 0.0,
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
    );
  }

  //list data temporary buat nampilin chart di card prodi
  List<PieChartSectionData> getSectionsProdi() {
    return [
      PieChartSectionData(
        showTitle: false,
        color: kGreen,
        value: 45,
        radius: 15,
      ),
      PieChartSectionData(
        showTitle: false,
        color: kYellow,
        value: 5,
        radius: 15,
      ),
      PieChartSectionData(
        showTitle: false,
        color: kLightBlue,
        value: 20,
        radius: 15,
      ),
      PieChartSectionData(
        showTitle: false,
        color: kBlue,
        value: 30,
        radius: 15,
      ),
    ];
  }
}

class DeskripsiChartProdi extends StatelessWidget {
  final Color color;
  final String title;
  final String percent;
  final String value;
  const DeskripsiChartProdi(
      {super.key,
      required this.color,
      required this.title,
      required this.percent,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            kGap8,
            Text(
              title,
              style:
                  Styles.kPublicRegularBodyTwo.copyWith(color: kLightGrey800),
            ),
            const Spacer(),
            Text(
              percent,
              style:
                  Styles.kPublicRegularBodyTwo.copyWith(color: kLightGrey500),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: kLightGrey100,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(
              value,
              style: Styles.kPublicSemiBoldBodyTwo.copyWith(color: kGrey900),
            ),
            kGap16,
            SvgPicture.asset(
              icRightArrow,
              width: 24,
            ),
          ],
        ),
      ],
    );
  }
}
