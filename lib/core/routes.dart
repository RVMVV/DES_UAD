import 'package:des_uad/splash.dart';
import 'package:flutter/material.dart';

import '../init_screens/fragment_view.dart';
import '../screens/akademik/aik/aik.dart';
import '../screens/akademik/akademik.dart';
import '../screens/akademik/jurnal_uad/jurnal_uad.dart';
import '../screens/akademik/keberhasilan_studi/keberhasilan_studi.dart';
import '../screens/akademik/kelulusan/kelulusan.dart';
import '../screens/akademik/mahasiswa_asing/mahasiswa_asing.dart';
import '../screens/akademik/mahasiswa_lokal/mahasiswa_lokal.dart';
import '../screens/akademik/perpustakaan/perpustakaan.dart';
import '../screens/akademik/pmb/pmb.dart';
import '../screens/akademik/publikasi/publikasi.dart';
import 'constant_finals.dart';

class Routes {
  static Map<String, Widget Function(BuildContext context)> routes = {
    splashRoute: (context) => const Splash(),
    homeRoute: (context) => const FragmentPage(),
    akademikRoute: (context) => const AkademikPage(),
    pmbRoute: (context) => const PenerimaanMahasiswaBaruPage(),
    mhsLokalRoute: (context) => const MahasiswaLokalPage(),
    mhsAsingRoute: (context) => const MahasiswaAsingPage(),
    kelulusanRoute: (context) => const KelulusanPage(),
    keberhasilanStudiRoute: (context) => const KeberhasilanStudiPage(),
    perpustakaanRoute: (context) => const PerpustakaanPage(),
    publikasiRoute: (context) => const PublikasiPage(),
    jurnalRoute: (context) => const JurnalUADPage(),
    aikRoute: (context) => const AIKPage(),
  };
}
