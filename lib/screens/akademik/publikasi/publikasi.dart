import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constant_finals.dart';
import '../../widgets/base_container.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';
import 'widgets/button_filter_publikasi.dart';
import 'widgets/item_publikasi.dart';

class PublikasiPage extends StatelessWidget {
  const PublikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodySubMenuAkademik(
        appBar: const AppBarSubMenuAkademik(
          title: 'Publikasi',
        ),
        // height: MediaQuery.sizeOf(context).height,
        children: [
          BaseContainer.styledBigCard(
            children: const [
              Gap(100),
            ],
          ),
          kGap24,
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: const [
                ButtonFilterPublikasi(
                  title: 'Documents',
                  isActive: true,
                ),
                kGap12,
                ButtonFilterPublikasi(
                  title: 'Citation',
                ),
                kGap12,
                ButtonFilterPublikasi(
                  title: 'Cited Documents',
                ),
                kGap12,
                ButtonFilterPublikasi(
                  title: 'Citation Per Researchers',
                ),
              ],
            ),
          ),
          kGap16,
          BaseContainer.styledBigCard(
            children: const [
              ItemPublikasi(
                asset: imgScopus,
                title: 'Scopus',
                value: '2.905',
              ),
              kGap20,
              ItemPublikasi(
                asset: imgScholar,
                title: 'GScholar',
                value: '40.648',
              ),
              kGap20,
              ItemPublikasi(
                asset: imgScholar,
                title: 'WOS',
                value: '62',
              ),
              kGap20,
              ItemPublikasi(
                asset: imgGaruda,
                title: 'Garuda',
                value: '9.979',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
