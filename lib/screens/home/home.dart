import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant_finals.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/sdm_cubit.dart';
import '../widgets/card_akreditasi_prodi.dart';
import '../widgets/card_baitul_arqom.dart';
import '../widgets/card_prestasi_mahasiswa.dart';
import '../widgets/card_tbq.dart';
import '../widgets/card_ratio.dart';
import '../widgets/card_student_body.dart';
import '../widgets/card_total_registration.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SdmCubit sdmCubit = context.read<SdmCubit>();
    final HomeCubit homeCubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: kBackground,
      body: RefreshIndicator(
        onRefresh: () async {
          homeCubit.getStudentBody();
          sdmCubit.getJumlahDosenTendik();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Assalamualaikum 👋',
                  style: Styles.kPublicRegularBodyOne.copyWith(
                    color: kLightGrey500,
                  ),
                ),
                Text(
                  'Yuk Mulai Pantau DES!',
                  style: Styles.kPublicSemiBoldHeadingThree
                      .copyWith(color: kGrey900),
                ),
                kGap20,
                const CardTotalRegistration(),
                kGap16,
                CardStudentBody(),
                kGap16,
                BlocBuilder<SdmCubit, SdmState>(
                  bloc: sdmCubit..getJumlahDosenTendik(),
                  builder: (context, state) {
                    if (state is SdmJumlahDosenTendik) {
                      return Column(
                        children: [
                          CardRatio(
                            title: 'Dosen',
                            total: state.dataDosen.data.totalDosen,
                            ratio: state.dataDosen.data.rasioDosen,
                            svgIcon: icProfileTwoUser,
                          ),
                          kGap16,
                          CardRatio(
                            title: 'Tendik',
                            total: state.dataTendik.data.totalTendik,
                            ratio: state.dataTendik.data.rasioTendik,
                            svgIcon: icBriefcase,
                          ),
                        ],
                      );
                    }
                    return const CardRatio(
                      title: '--',
                      total: '--',
                      ratio: '--',
                      svgIcon: icProfileTwoUser,
                    );
                  },
                ),

                //return kalo datanya gaada
                kGap16,
                const CardAkreditasiProdi(),
                kGap16,
                const CardMahasiswaLulusTBQ(),
                kGap16,
                const CardBaitulArqom(),
                kGap16,
                const CardPrestasiMahasiswa(),
                kGap16
              ],
            ),
          ),
        ),
      ),
    );
  }
}
