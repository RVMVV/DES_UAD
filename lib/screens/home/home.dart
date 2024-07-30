import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SdmCubit sdmCubit;
  late HomeCubit homeCubit;
  String email = '';
  @override
  void initState() {
    super.initState();
    sdmCubit = context.read<SdmCubit>();
    homeCubit = context.read<HomeCubit>();
    _loadData();
  }

  void _loadData() {
    homeCubit.getStudentBody();
    sdmCubit.getJumlahDosenTendik();
  }

  // void sess() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var email = pref.getString('useremail');
  //   setState(() {
  //     email = email;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: RefreshIndicator(
        onRefresh: () async {
          _loadData();
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
                InkWell(
                  onTap: () => Navigator.pushNamed(context, pmbRoute).then((_) {
                    // Load data again when returning to HomeScreen
                    _loadData();
                  }),
                  child: const CardTotalRegistration(),
                ),
                kGap16,
                const CardStudentBody(),
                kGap16,
                BlocBuilder<SdmCubit, SdmState>(
                  bloc: sdmCubit,
                  builder: (context, state) {
                    if (state is SdmJumlahDosenTendik) {
                      return Column(
                        children: [
                          CardRatio(
                            title: 'Dosen',
                            total: state.dataDosen.data.totalDosen,
                            ratio: state.dataDosen.data.rasioDosen,
                            svgIcon: icProfileTwoUser,
                            // seeAll: 'Lihat Semua',
                          ),
                          kGap16,
                          CardRatio(
                            title: 'Tendik',
                            total: state.dataTendik.data.totalTendik,
                            ratio: state.dataTendik.data.rasioTendik,
                            svgIcon: icBriefcase,
                            // seeAll: 'Lihat Semua',
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
                kGap16,
                const CardAkreditasiProdi(),
                kGap16,
                // const CardMahasiswaLulusTBQ(),
                // kGap16,
                // const CardBaitulArqom(),
                // kGap16,
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
