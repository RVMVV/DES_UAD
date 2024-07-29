import 'package:flutter/material.dart';

import '../../core/constant_finals.dart';
import '../widgets/card_student_body.dart';
import 'widgets/item_akademik_menu.dart';

class AkademikPage extends StatelessWidget {
  const AkademikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            centerTitle: false,
            title: Text('Akademik'),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              kGap16,
              CardStudentBody(),
              kGap24,
              Text(
                'Menu Akademik',
                style:
                    Styles.kPublicSemiBoldHeadingFour.copyWith(color: kGrey900),
              ),
              kGap12,
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 100 / 120,
                padding: EdgeInsets.zero,
                physics: const ScrollPhysics(),
                children: const [
                  ItemAkademikMenu(
                    asset: icProfileAdd,
                    iconColor: Color(0xFF3490FC),
                    side: 40,
                    title: 'PMB',
                    route: pmbRoute,
                  ),
                  ItemAkademikMenu(
                    asset: icFrame,
                    iconColor: Color(0xFF00A991),
                    side: 40,
                    title: 'Mahasiswa Lokal',
                    route: mhsLokalRoute,
                  ),
                  ItemAkademikMenu(
                    asset: icUserOctagon,
                    iconColor: Color(0xFFFFB444),
                    side: 40,
                    title: 'Mahasiswa Asing',
                    route: mhsAsingRoute,
                  ),
                  ItemAkademikMenu(
                    asset: icTeacherFill,
                    iconColor: Color(0xFF3490FC),
                    side: 40,
                    title: 'Kelulusan',
                    route: kelulusanRoute,
                  ),
                  ItemAkademikMenu(
                    asset: icAward,
                    iconColor: Color(0xFFFFB444),
                    side: 40,
                    title: 'Keberhasilan Studi',
                    route: keberhasilanStudiRoute,
                  ),
                  ItemAkademikMenu(
                    asset: icBook,
                    iconColor: Color(0xFF00A991),
                    side: 40,
                    title: 'Perpustakaan',
                    route: perpustakaanRoute,
                  ),
                  // ItemAkademikMenu(
                  //   asset: icSearchStatus,
                  //   iconColor: Color(0xFF3490FC),
                  //   side: 40,
                  //   title: 'Publikasi',
                  //   route: publikasiRoute,
                  // ),
                  // ItemAkademikMenu(
                  //   asset: icClipboard,
                  //   iconColor: Color(0xFF00A991),
                  //   side: 40,
                  //   title: 'Jurnal UAD',
                  //   route: jurnalRoute,
                  // ),
                  // ItemAkademikMenu(
                  //   asset: icNote,
                  //   iconColor: Color(0xFFFFB444),
                  //   side: 40,
                  //   title: 'AIK',
                  //   route: aikRoute,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
