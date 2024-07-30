import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/pmb_cubit.dart';
import '../../widgets/base_container.dart';
import 'section_persebaran_fakultas_dosen.dart';
import 'section_persebaran_prodi_dosen.dart';

class PersebaranDosen extends StatefulWidget {
  final String title;
  const PersebaranDosen({
    required this.title,
    super.key,
  });

  @override
  State<PersebaranDosen> createState() => _PersebaranState();
}

class _PersebaranState extends State<PersebaranDosen> {
  bool showAllData = false;
  bool isFakultasSelected = true;
  String selectedFakultas = 'Teknologi Industri'; //placeholder
  String fakultasKode = '';

  @override
  void initState() {
    super.initState();
    final pmbCubit = context.read<PmbCubit>();
    pmbCubit.getRefFakultas();
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
              visible: isFakultasSelected,
              child: SdmPersebaranDosenFakultas(showAllData: showAllData),
            ),
            Visibility(
              visible: !isFakultasSelected,
              child: GestureDetector(
                onTap: () => showFakultasSelection(),
                child: SdmPersebaranProdiDosen(
                  selectedFakultas: selectedFakultas,
                  fakKode: fakultasKode,
                ),
              ),
            ),
            kGap16,
            InkWell(
              onTap: () {
                setState(() {
                  showAllData = !showAllData;

                });
              },
              child: Center(
                child: Text(
                  showAllData ? 'Ciutkan' : 'Lihat Semua',
                  style: Styles.kPublicRegularBodyTwo.copyWith(
                    color: kGrey500,
                  ),
                ),
              ),
            ),
            kGap16,
          ],
        ),
      ),
    );
  }

  void toggleSelection(bool isDosen) {
    setState(() {
      isFakultasSelected = isDosen;
    });
  }

  void showFakultasSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: BlocBuilder<PmbCubit, PmbState>(
            builder: (context, state) {
              if (state is RefFakultasLoaded) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
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
                          String fkKode = state.data[index].fakKode;
                          return ListTile(
                            leading: data == selectedFakultas
                                ? const Icon(Icons.check, color: kBlue)
                                : null,
                            onTap: () {
                              setState(() {
                                selectedFakultas = data;
                                fakultasKode = fkKode;
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
          ),
        );
      },
      backgroundColor: kWhite,
    );
  }
}
