import 'package:des_uad/cubit/sdm_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import '../../../core/constant_finals.dart';
import '../../../cubit/mutu_cubit.dart';
import '../../../cubit/sdm_pre_cubit.dart';
import '../../../data/data_chart.dart';
import '../../../data/models/sdm/sdm_pendidikan_dosen_model.dart';
import '../../../data/models/sdm/sdm_persebaran_prodi_dosen_model.dart';
import '../../widgets/base_container.dart';
import '../../widgets/big_card_title.dart';
import '../../widgets/chart/horizontal_bar_chart.dart';

class Persebaran extends StatefulWidget {
  final String title;
  const Persebaran({
    required this.title,
    super.key,
  });

  @override
  State<Persebaran> createState() => _PersebaranState();
}

class _PersebaranState extends State<Persebaran> {
  bool isFakultasSelected = true; // Menambahkan variabel status
  String selectedFakultas =
      'Teknologi Industri'; // Menambahkan variabel pilihan

  final akreditasis = [
    AkreditasiInternasional('Informatika', 50, '37'),
    AkreditasiInternasional('Teknik Elektro', 20, '33'),
    AkreditasiInternasional('Teknik Industri', 15, '33'),
    AkreditasiInternasional('Teknik Kimia', 10, '33'),
    AkreditasiInternasional('Teknik Pangan', 5, '33'),
  ];

  @override
  void initState() {
    super.initState();
    final MutuCubit cubit = context.read<MutuCubit>();
    final SdmCubit sdmCubit = context.read<SdmCubit>();
    final SdmPreCubit sdmPreCubit = context.read<SdmPreCubit>();
    cubit.getSertifikasiProdi();
    sdmCubit.getPersebaranProdiDosen();
    sdmPreCubit.getPersebaranFakultasDosen();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Styles.kPublicSemiBoldBodyOne.copyWith(
                color: kGrey900,
              ),
            ),
            kGap20,
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: kLightGrey100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => toggleSelection(true), // ubah status
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: isFakultasSelected
                                    ? kWhite
                                    : kLightGrey100, // Mengubah warna berdasarkan status
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Fakultas',
                                  style:
                                      Styles.kPublicSemiBoldBodyThree.copyWith(
                                    color: kGrey900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        kGap8,
                        Expanded(
                          child: GestureDetector(
                            onTap: () => toggleSelection(false), // ubah status
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color:
                                    isFakultasSelected ? kLightGrey100 : kWhite,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Prodi',
                                  style:
                                      Styles.kPublicSemiBoldBodyThree.copyWith(
                                    color: kGrey900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            kGap20,
            Visibility(
              visible: !isFakultasSelected,
              child: GestureDetector(
                onTap: () => showFakultasSelection(),
                child: Column(
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
                              selectedFakultas,
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
                        buildWhen: (previous, current) =>
                            current is SdmPersebaranFakultas,
                        builder: (context, state) {
                          print(state);
                          if (state is PersebaranProdiDosenLoaded) {
                            final dataPersebaranProdiDosen = [
                              charts.Series<DataPersebaranProdiDosen, String>(
                                id: 'AI',
                                data: state.data,
                                domainFn: (datum, index) => datum.prodi,
                                measureFn: (datum, index) => double.parse(
                                    datum.persentase.replaceAll('%', '')),
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
                                    double.parse(
                                        datum.persentase.replaceAll('%', '')),
                                data: state.data,
                                labelAccessorFn: (datum, index) => '',
                                colorFn: (datum, index) => const charts.Color(
                                    r: 52, g: 144, b: 252, a: 32),
                              )
                            ];
                            return HorizontalBarLabelChart(
                                dataPersebaranProdiDosen);
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isFakultasSelected,
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: BlocBuilder<SdmPreCubit, SdmPreState>(
                      buildWhen: (previous, current) =>
                          current is SdmFakultasDosen,
                      builder: (context, state) {
                        print(state);
                        if (state is PersebaranFakultasDosenLoaded) {
                          final dataPersebaranFakultasDosen = [
                            charts.Series<DataPersebaranProdiDosen, String>(
                              id: 'AI',
                              data: state.data,
                              domainFn: (datum, index) => datum.fakultas,
                              measureFn: (datum, index) => double.parse(
                                  datum.persentase.replaceAll('%', '')),
                              labelAccessorFn: (datum, index) =>
                                  '${datum.fakultas}:   ${datum.persentase} ● ${datum.total}',
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
                              domainFn: (datum, index) => datum.fakultas,
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
                          return HorizontalBarLabelChart(
                              dataPersebaranFakultasDosen);
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
            kGap20,
          ],
        ),
      ),
    );
  }

  void toggleSelection(bool isDosen) {
    setState(() {
      isFakultasSelected = isDosen;
      // print(isDosen);
    });
  }

  void showFakultasSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<MutuCubit, MutuState>(
          buildWhen: (previous, current) => current is AkreditasiTersertifikasi,
          builder: (context, state) {
            if (state is AkreditasiPersebaranTersertifikasiProdiLoaded) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16),
                    child: Text(
                      'Pilih Fakultas',
                      style: Styles.kPublicSemiBoldHeadingFour
                          .copyWith(color: kGrey900),
                    ),
                  ),
                  Divider(
                    color: kLightGrey300.withOpacity(30 / 100),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        String data = state.data[index].prodi;
                        return ListTile(
                          leading: data == selectedFakultas
                              ? const Icon(Icons.check, color: kBlue)
                              : null,
                          onTap: () {
                            setState(() {
                              selectedFakultas = data;
                            });
                            Navigator.pop(context);
                          },
                          title: Text(
                            data,
                            style: Styles.kInterMediumBodyOne.copyWith(
                              color: kGrey900,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            color: kLightGrey300.withOpacity(30 / 100),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        );
      },
      backgroundColor: kWhite,
    );
  }
}
