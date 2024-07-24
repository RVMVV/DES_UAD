import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant_finals.dart';

import '../../../../cubit/pmb_cubit.dart';
import '../../../widgets/base_container.dart';
import 'pmb_reg_fakultas_chart.dart';
import 'pmb_reg_prodi_chart.dart';

class PmbJalurReg extends StatefulWidget {
  final String title;
  const PmbJalurReg({
    required this.title,
    super.key,
  });

  @override
  State<PmbJalurReg> createState() => _PmbJalurRegState();
}

class _PmbJalurRegState extends State<PmbJalurReg> {
  bool isFakultasSelectedReg = false;
  bool isProdiSelectedReg = false;
  bool showProdiReg = true;

  String selectedFakultas = 'Teknologi Industri';
  String selectedFakKode = 'fti'; // Menambahkan variabel pilihan

  @override
  void initState() {
    super.initState();
    toggleSelection(0);
  }

  void toggleSelection(int tab) {
    print(tab);
    setState(() {
      if (tab == 1) {
        isFakultasSelectedReg = false;
        isProdiSelectedReg = true;
      } else if (tab == 0) {
        isFakultasSelectedReg = true;
        isProdiSelectedReg = false;
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
                                color: isFakultasSelectedReg
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
                                color:
                                    isProdiSelectedReg ? kWhite : kLightGrey100,
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
              visible: (isProdiSelectedReg) ? true : false,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showFakultasPersebaran();
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
                  if (showProdiReg)
                    PmbRegProdiChart(
                      fakKode: selectedFakKode,
                    )
                ],
              ),
            ),
            Visibility(
              visible: (isFakultasSelectedReg == true) ? true : false,
              child: PmbRegFakultasChart(),
            ),
            kGap20,
          ],
        ),
      ),
    );
  }

  void showFakultasPersebaran() {
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
                              showProdiReg = false;
                              selectedFakultas = data;
                              selectedFakKode = idFak;
                            });

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              setState(() {
                                showProdiReg = true;
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
