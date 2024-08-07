import 'package:des_uad/cubit/pmb_cubit.dart';
import 'package:des_uad/cubit/sdm_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant_finals.dart';
import '../../../../cubit/mutu_cubit.dart';
import '../../../../cubit/sdm_pre_cubit.dart';
import '../../../widgets/base_container.dart';
import 'persebaran_fakultas_chart.dart';
import 'persebaran_prodi_chart.dart';
import 'persebaran_provinsi_chart.dart';

class PersebaranUnitPmb extends StatefulWidget {
  final String title;
  const PersebaranUnitPmb({
    required this.title,
    super.key,
  });

  @override
  State<PersebaranUnitPmb> createState() => _PersebaranState();
}

class _PersebaranState extends State<PersebaranUnitPmb> {
  bool isFakultasSelected = false;
  bool isProdiSelected = false;
  bool isProvinsiSelected = false;
  bool showProdiPmb = true;
  bool showAllProvinsi = false;
  int selectedTab = 0;
  String selectedFakultas = 'Teknologi Industri';
  String selectedFakKode = 'fti'; // Menambahkan variabel pilihan

  @override
  void initState() {
    super.initState();
    toggleSelection(0);
    final MutuCubit cubit = context.read<MutuCubit>();
    final SdmCubit sdmCubit = context.read<SdmCubit>();
    final SdmPreCubit sdmPreCubit = context.read<SdmPreCubit>();
    cubit.getSertifikasiProdi();
    sdmCubit.getPersebaranProdiDosen();
    sdmPreCubit.getPersebaranFakultasDosen();
    selectedTab = 0;
  }

  void toggleSelection(int tab) {
    // print(tab);
    setState(() {
      if (tab == 1) {
        isFakultasSelected = false;
        isProdiSelected = true;
        isProvinsiSelected = false;
      } else if (tab == 2) {
        isFakultasSelected = false;
        isProdiSelected = false;
        isProvinsiSelected = true;
      } else if (tab == 0) {
        isFakultasSelected = true;
        isProdiSelected = false;
        isProvinsiSelected = false;
      }
    });
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
                            onTap: () => toggleSelection(0), // ubah status
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
                            onTap: () => toggleSelection(1), // ubah status
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: isProdiSelected ? kWhite : kLightGrey100,
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
                        kGap8,
                        Expanded(
                          child: GestureDetector(
                            onTap: () => toggleSelection(2), // ubah status
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color:
                                    isProvinsiSelected ? kWhite : kLightGrey100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Provinsi',
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
              visible: (isProdiSelected) ? true : false,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showFakultasPersebaran2();
                    },
                    child: Container(
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
                  ),
                  if (showProdiPmb)
                    PersebaranProdiChart(
                      fakKode: selectedFakKode,
                    )
                  //print selectedFakKode
                ],
              ),
            ),
            Visibility(
              visible: (isFakultasSelected == true) ? true : false,
              child: PersebaranFakultasChart(),
            ),
            Visibility(
              visible: (isProvinsiSelected == true) ? true : false,
              child: PersebaranProvinsiChart(
                showAllProvinsi: showAllProvinsi,
              ),
            ),
            kGap20,
            Visibility(
              visible: isProvinsiSelected == true ? true : false,
              child: const Divider(),
            ),
            Visibility(
              visible: isProvinsiSelected == true ? true : false,
              child: Center(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    showAllProvinsi = !showAllProvinsi;
                  });
                  print(showAllProvinsi);
                },
                child: Text(
                  showAllProvinsi ? 'Ciutkan' : 'Lihat Semua',
                  style: Styles.kPublicRegularBodyTwo.copyWith(
                    color: kGrey500,
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  void showFakultasPersebaran2() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final pmbCubit = context.read<PmbCubit>();
        return BlocBuilder<PmbCubit, PmbState>(
          bloc: pmbCubit..getRefFakultas(),
          builder: (context, state) {
            if (state is RefFakultasLoaded) {
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
                        String data = state.data[index].fakultas;
                        String idFak = state.data[index].fakKode;

                        return ListTile(
                          leading: data == selectedFakultas
                              ? const Icon(Icons.check, color: kBlue)
                              : null,
                          onTap: () {
                            setState(() {
                              showProdiPmb = false;
                              selectedFakultas = data;
                              selectedFakKode = idFak;
                            });

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              setState(() {
                                showProdiPmb = true;
                              });
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
