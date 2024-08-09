import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/akademik_cubit.dart';
import '../../widgets/base_container.dart';
import '../../widgets/rounded_icon_container.dart';
import '../widgets/app_bar_sub_menu_akademik.dart';
import '../widgets/body_sub_menu_akademik.dart';

class PerpustakaanPage extends StatelessWidget {
  const PerpustakaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();

    return Scaffold(
      body: BodySubMenuAkademik(
        appBar: const AppBarSubMenuAkademik(
          title: 'Perpustakaan',
        ),
        // height: MediaQuery.sizeOf(context).height,
        children: [
          kGap16,
          BaseContainer.styledBigCard(
            isRow: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Judul Koleksi',
                    style: Styles.kPublicRegularBodyTwo,
                  ),
                  BlocBuilder<AkademikCubit, AkademikState>(
                    bloc: akademikCubit..getKoleksi(),
                    buildWhen: (previous, current) => current is KoleksiState,
                    builder: (context, state) {
                      if (state is KoleksiLoaded) {
                        return Text(
                          state.data.total,
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
                asset: icNoteTwo,
              ),
            ],
          ),
          kGap16,
          GridView.count(
            childAspectRatio: 150 / 110,
            crossAxisCount: 2,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              BlocBuilder<AkademikCubit, AkademikState>(
                bloc: akademikCubit..getKoleksi(),
                buildWhen: (previous, current) => current is KoleksiState,
                builder: (context, state) {
                  if (state is KoleksiLoaded) {
                    return ItemPerpustakaan(
                      icon: icBook,
                      title: 'Total Buku',
                      value: state.data.totalBuku,
                    );
                  }
                  return const ItemPerpustakaan(
                    icon: icBook,
                    title: 'Total Buku',
                    value: '...',
                  );
                },
              ),
              BlocBuilder<AkademikCubit, AkademikState>(
                bloc: akademikCubit..getKoleksi(),
                buildWhen: (previous, current) => current is KoleksiState,
                builder: (context, state) {
                  if (state is KoleksiLoaded) {
                    return ItemPerpustakaan(
                      icon: icClipboard,
                      title: 'Total Jurnal',
                      value: state.data.totalJurnal,
                    );
                  }
                  return const ItemPerpustakaan(
                    icon: icClipboard,
                    title: 'Total Jurnal',
                    value: '...',
                  );
                },
              ),
              BlocBuilder<AkademikCubit, AkademikState>(
                bloc: akademikCubit..getEksemplar(),
                buildWhen: (previous, current) => current is EksamplarState,
                builder: (context, state) {
                  if (state is EksamplarLoaded) {
                    return ItemPerpustakaan(
                      icon: icBookTwo,
                      title: 'Total Eksemplar',
                      value: state.data,
                    );
                  }
                  return const ItemPerpustakaan(
                    icon: icBookTwo,
                    title: 'Total Eksemplar',
                    value: '...',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemPerpustakaan extends StatelessWidget {
  const ItemPerpustakaan({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final String icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return BaseContainer.styledBigCard(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RoundedIconContainer(
              side: 36,
              color: kLightGrey100,
              iconColor: kBlue,
              asset: icon,
            ),
            kGap8,
            Text(
              title,
              style: Styles.kPublicMediumBodyThree.copyWith(color: kGrey600),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            value,
            style: Styles.kPublicSemiBoldHeadingThree,
          ),
        )
      ],
    );
  }
}
