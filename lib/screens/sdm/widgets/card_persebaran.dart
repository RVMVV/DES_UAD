import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant_finals.dart';
import '../../../data/data_chart.dart';
import '../../widgets/base_container.dart';

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

  //list fakultas
  List<String> fakultasList = [
    'Teknologi Industri',
    'Fakultas Farmasi',
    'Kedokteran',
    'FKIP',
  ];

  final akreditasis = [
    AkreditasiInternasional('Informatika', 50, '37'),
    AkreditasiInternasional('Teknik Elektro', 20, '33'),
    AkreditasiInternasional('Teknik Industri', 15, '33'),
    AkreditasiInternasional('Teknik Kimia', 10, '33'),
    AkreditasiInternasional('Teknik Pangan', 5, '33'),
  ];

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
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Text(
                'Pilih Fakultas',
                style:
                    Styles.kPublicSemiBoldHeadingFour.copyWith(color: kGrey900),
              ),
            ),
            Divider(
              color: kLightGrey300.withOpacity(30 / 100),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: fakultasList.length,
                itemBuilder: (BuildContext context, int index) {
                  String data = fakultasList[index];
                  return ListTile(
                    leading: data == selectedFakultas
                        ? const Icon(Icons.check, color: kBlue)
                        : null,
                    title: Text(
                      data,
                      style: Styles.kInterMediumBodyOne.copyWith(
                        color: kGrey900,
                      ),
                    ),
                    // trailing: Divider(),
                    onTap: () {
                      setState(() {
                        selectedFakultas = data;
                      });
                      Navigator.pop(context);
                    },
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
      },
      backgroundColor: kWhite,
    );
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
                child: Row(
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
                              style: Styles.kPublicSemiBoldBodyThree.copyWith(
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
                            color: isFakultasSelected ? kLightGrey100 : kWhite,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Prodi',
                              style: Styles.kPublicSemiBoldBodyThree.copyWith(
                                color: kGrey900,
                              ),
                            ),
                          ),
                        ),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
