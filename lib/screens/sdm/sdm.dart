// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:des_uad/screens/sdm/dosen/sdm_dosen.dart';
import 'package:flutter/material.dart';

import '../../core/constant_finals.dart';
import 'tendik/sdm_tendik.dart';

class SumberDayaManusia extends StatefulWidget {
  const SumberDayaManusia({super.key});

  @override
  _SumberDayaManusiaState createState() => _SumberDayaManusiaState();
}

class _SumberDayaManusiaState extends State<SumberDayaManusia> {
  bool isDosenSelected = true; // Menambahkan variabel status

  void toggleSelection(bool isDosen) {
    setState(() {
      isDosenSelected = isDosen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: kWhite,
        surfaceTintColor: kWhite,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sumber Daya Manusia',
              style: Styles.kPublicSemiBoldHeadingTwo.copyWith(color: kGrey),
            ),
            kGap16,
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
                        onTap: () => toggleSelection(true), // Mengubah status
                        child: Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: isDosenSelected
                                ? kWhite
                                : kLightGrey100, // Mengubah warna berdasarkan status
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Dosen',
                              style: Styles.kPublicSemiBoldBodyThree.copyWith(
                                color: kGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    kGap8,
                    Expanded(
                      child: GestureDetector(
                        onTap: () => toggleSelection(false), // Mengubah status
                        child: Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: isDosenSelected
                                ? kLightGrey100
                                : kWhite, // Mengubah warna berdasarkan status
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Tendik',
                              style: Styles.kPublicSemiBoldBodyThree.copyWith(
                                color: kGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: isDosenSelected ? SDMDosen() : SDMTendik(),
    );
  }
}
