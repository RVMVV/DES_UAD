import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

const String url = 'http://d3v.uad.id/ipm/index.php/des/';
final Map<String, dynamic> endpoint = {
  'mahasiswa_asing': {
    'jumlah': 'mahasiswa_asing',
    'persebaran_negara': 'persebaran_mahasiswa_asing',
  },
  'pmb': {
    'dataPMB': 'maba_jumlah_mahasiswa',
    'persebaran_fakultas': 'maba_jumlah_mahasiswa_fakultas',
    'persebaran_provinsi': 'maba_jumlah_mahasiswa_provinsi',
  },
  'kelulusan': {
    'tren': 'akademik_statistik_kelulusan',
    'perbandingan': 'akademik_perbandingan_kelulusan',
  },
  'keberhasilan': {
    'mhs': 'akademik_statistik_keberhasilan_studi',
    'perbandingan': 'perbandingan_total_mahasiswa',
  },
  'perpustakaan': {
    'koleksi': 'perpus_jumlah_koleksi',
    'eksemplar': 'perpus_jumlah_eksemplar',
  },
  'mahasiswa_status': {
    'jumlah': 'akademik_student_body',
    'status': 'akademik_student_status',
  },
  'mutu': {
    'akreditasi': {
      'total': 'akreditasi_jumlah_prodi',
      'prodi': 'akreditasi_persebaran',
      // 'akreditasi':
      'sertifikasi': 'akreditasi_persebaran_tersertifikasi_prodi',
      'internasional': 'akreditasi_persebaran_internasional',
      'akre_prodi': 'akreditasi_persebaran_tersertifikasi_prodi',
    }
  },
  'sdm': {
    'sdm_dosen': {
      'ratio_jumlah': 'sdm_jumlah_dosen',
      'gender': 'sdm_dosen_gender',
      'fungsional': 'sdm_dosen_fungsional',
      'pendidikan': 'sdm_dosen_pendidikan',
      'persebaran_prodi': 'sdm_dosen_prodi',
      'persebaran_fakultas': 'sdm_dosen_fakultas',
    },
    'sdm_tendik': {
      'ratio_jumlah': 'sdm_jumlah_tendik',
      'gender': 'sdm_tendik_gender',
      'fungsional': 'sdm_tendik_fungsional',
      'pendidikan': 'sdm_tendik_pendidikan',
    }
  },
  'prestasi': {'mahasiswa': 'prestasi_tren_tiga_tahun'}
};
// Spacing (Gap)
const Gap kGap4 = Gap(4);
const Gap kGap8 = Gap(8);
const Gap kGap12 = Gap(12);
const Gap kGap16 = Gap(16);
const Gap kGap20 = Gap(20);
const Gap kGap24 = Gap(24);
const Gap kGap28 = Gap(28);
const Gap kGap32 = Gap(32);
const Gap kGap80 = Gap(80);
const Gap kGap70 = Gap(70);

// Route
const String homeRoute = 'home/';
const String akademikRoute = 'akademik/';
const String pmbRoute = '${akademikRoute}pmb/';
const String mhsLokalRoute = '${akademikRoute}mhslokal/';
const String mhsAsingRoute = '${akademikRoute}mhsasing/';
const String kelulusanRoute = '${akademikRoute}kelulusan/';
const String keberhasilanStudiRoute = '${akademikRoute}keberhasilanstudi/';
const String perpustakaanRoute = '${akademikRoute}perpustakaan/';
const String publikasiRoute = '${akademikRoute}publikasi/';
const String jurnalRoute = '${akademikRoute}jurnal/';
const String aikRoute = '${akademikRoute}aik/';

// Image
const String imgLoc = 'assets/images/';
const String imgScopus = '${imgLoc}scopus.png';
const String imgGaruda = '${imgLoc}garuda.png';
const String imgScholar = '${imgLoc}scholar.png';

// Icon
const String icLoc = 'assets/svgs/';
const String icBriefcase = '${icLoc}briefcase.svg';
const String icProfileTwoUser = '${icLoc}profiletwouser.svg';
const String icHome = '${icLoc}home.svg';
const String icPeople = '${icLoc}people.svg';
const String icProfileTwoUserOutline = '${icLoc}profiletwouseroutline.svg';
const String icChart = '${icLoc}chart.svg';
const String icTeacherFill = '${icLoc}teacher-fill.svg';
const String icTeacherOutline = '${icLoc}teacher-outline.svg';
const String icArrowBottom = '${icLoc}arrow-bottom.svg';
const String icMedal = '${icLoc}medal.svg';
const String icMedalOutline = '${icLoc}medal-outline.svg';
const String icMedalStar = '${icLoc}medal-star.svg';
const String icFrame = '${icLoc}frame.svg';
const String icNoteTwo = '${icLoc}note-2.svg';
const String icProfileTick = '${icLoc}profile-tick.svg';
const String icTaskSquare = '${icLoc}task-square.svg';
const String icNote = '${icLoc}note.svg';
const String icClipboard = '${icLoc}clipboard.svg';
const String icSearchStatus = '${icLoc}search-status.svg';
const String icBook = '${icLoc}book.svg';
const String icBookTwo = '${icLoc}book-2.svg';
const String icAward = '${icLoc}award.svg';
const String icUserOctagon = '${icLoc}user-octagon.svg';
const String icProfileAdd = '${icLoc}profile-add.svg';
const String icManGender = '${icLoc}gender-man.svg';
const String icWomanGender = '${icLoc}gender-woman.svg';
const String icRightArrow = '${icLoc}circulararrowright.svg';

//Warna
const Color kTransparent = Color(0x00000000);
const Color kBackground = Color(0xFFEFF3FA);
const Color kWhite = Color(0xFFFFFFFF);
const Color kIvoryWhite = Color(0xFFE8ECF4);
const Color kBlue = Color(0xFF2080F9);
// const Color kLightBlue = Color(0xFFA9E1FD);
const Color kLightBlue = Color(0xFF3490FC);
const Color kLightSkyBlue = Color(0xFFA2CCFE);
// const Color kDeepSkyBlue = Color(0xFF45BDFB);
const Color kYellow = Color(0xFFFFB444);
const Color kPink = Color(0xFFFF5C76);
const Color kRed = Color(0xFFFF7368);
const Color kGreen = Color(0xFF00A991);
const Color kLightGreen = Color(0xFF8AD7CC);
const Color kPurple = Color(0xFF5F23FD);
const Color kLightPurple = Color(0xFF6B8BFF);
const Color kLightGrey100 = Color(0xFFF0F1F3);
const Color kLightGrey300 = Color(0xFF989FAD);
const Color kLightGrey400 = Color(0xFF858D9D);
const Color klightGrey450 = Color(0xFF6E7880);
const Color kLightGrey500 = Color(0xFF667085);
const Color kLightGrey800 = Color(0xFF383E49);
const Color kGrey50 = Color(0xFFF0F1F3);
const Color kGrey100 = Color(0xFFD0D3D9);
const Color kGrey300 = Color(0xFF989FAD);
const Color kGrey400 = Color(0xFF858D9D);
const Color kGrey500 = Color(0xFF667085);
const Color kGrey600 = Color(0xFF5D6679);
const Color kGrey800 = Color(0xFF383E49);
const Color kGrey900 = Color(0xFF2B2F38);

class Styles {
  //W400 - Regular
  static final TextStyle kPublicRegularHeadingOne =
      GoogleFonts.publicSans(fontWeight: FontWeight.w400, fontSize: 36);
  static final TextStyle kPublicRegularHeadingTwo =
      GoogleFonts.publicSans(fontWeight: FontWeight.w400, fontSize: 32);
  static final TextStyle kPublicRegularHeadingThree =
      GoogleFonts.publicSans(fontWeight: FontWeight.w400, fontSize: 24);
  static final TextStyle kPublicRegularHeadingFour =
      GoogleFonts.publicSans(fontWeight: FontWeight.w400, fontSize: 20);
  static final TextStyle kPublicRegularHeadingFive =
      GoogleFonts.publicSans(fontWeight: FontWeight.w400, fontSize: 18);
  static final TextStyle kPublicRegularBodyOne =
      GoogleFonts.publicSans(fontWeight: FontWeight.w400, fontSize: 16);
  static final TextStyle kPublicRegularBodyTwo =
      GoogleFonts.publicSans(fontWeight: FontWeight.w400, fontSize: 14);
  static final TextStyle kPublicRegularBodyThree =
      GoogleFonts.publicSans(fontWeight: FontWeight.w400, fontSize: 12);
  static final TextStyle kPublicRegularBodyFour =
      GoogleFonts.publicSans(fontWeight: FontWeight.w400, fontSize: 10);

  //W500 - Medium
  static final TextStyle kPublicMediumHeadingOne =
      GoogleFonts.publicSans(fontWeight: FontWeight.w500, fontSize: 36);
  static final TextStyle kPublicMediumHeadingTwo =
      GoogleFonts.publicSans(fontWeight: FontWeight.w500, fontSize: 32);
  static final TextStyle kPublicMediumHeadingThree =
      GoogleFonts.publicSans(fontWeight: FontWeight.w500, fontSize: 24);
  static final TextStyle kPublicMediumHeadingFour =
      GoogleFonts.publicSans(fontWeight: FontWeight.w500, fontSize: 20);
  static final TextStyle kPublicMediumHeadingFive =
      GoogleFonts.publicSans(fontWeight: FontWeight.w500, fontSize: 18);
  static final TextStyle kPublicMediumBodyOne =
      GoogleFonts.publicSans(fontWeight: FontWeight.w500, fontSize: 16);
  static final TextStyle kPublicMediumBodyTwo =
      GoogleFonts.publicSans(fontWeight: FontWeight.w500, fontSize: 14);
  static final TextStyle kPublicMediumBodyThree =
      GoogleFonts.publicSans(fontWeight: FontWeight.w500, fontSize: 12);
  static final TextStyle kPublicMediumBodyFour =
      GoogleFonts.publicSans(fontWeight: FontWeight.w500, fontSize: 10);

  //W600 - SemiBold
  static final TextStyle kPublicSemiBoldHeadingOne =
      GoogleFonts.publicSans(fontWeight: FontWeight.w600, fontSize: 36);
  static final TextStyle kPublicSemiBoldHeadingTwo =
      GoogleFonts.publicSans(fontWeight: FontWeight.w600, fontSize: 32);
  static final TextStyle kPublicSemiBoldHeadingThree =
      GoogleFonts.publicSans(fontWeight: FontWeight.w600, fontSize: 24);
  static final TextStyle kPublicSemiBoldHeadingFour =
      GoogleFonts.publicSans(fontWeight: FontWeight.w600, fontSize: 20);
  static final TextStyle kPublicSemiBoldHeadingFive =
      GoogleFonts.publicSans(fontWeight: FontWeight.w600, fontSize: 18);
  static final TextStyle kPublicSemiBoldBodyOne =
      GoogleFonts.publicSans(fontWeight: FontWeight.w600, fontSize: 16);
  static final TextStyle kPublicSemiBoldBodyTwo =
      GoogleFonts.publicSans(fontWeight: FontWeight.w600, fontSize: 14);
  static final TextStyle kPublicSemiBoldBodyThree =
      GoogleFonts.publicSans(fontWeight: FontWeight.w600, fontSize: 12);
  static final TextStyle kPublicSemiBoldBodyFour =
      GoogleFonts.publicSans(fontWeight: FontWeight.w600, fontSize: 10);

  //W700 - Bold
  static final TextStyle kPublicBoldHeadingOne =
      GoogleFonts.publicSans(fontWeight: FontWeight.w700, fontSize: 36);
  static final TextStyle kPublicBoldHeadingTwo =
      GoogleFonts.publicSans(fontWeight: FontWeight.w700, fontSize: 32);
  static final TextStyle kPublicBoldHeadingThree =
      GoogleFonts.publicSans(fontWeight: FontWeight.w700, fontSize: 24);
  static final TextStyle kPublicBoldHeadingFour =
      GoogleFonts.publicSans(fontWeight: FontWeight.w700, fontSize: 20);
  static final TextStyle kPublicBoldHeadingFive =
      GoogleFonts.publicSans(fontWeight: FontWeight.w700, fontSize: 18);
  static final TextStyle kPublicBoldBodyOne =
      GoogleFonts.publicSans(fontWeight: FontWeight.w700, fontSize: 16);
  static final TextStyle kPublicBoldBodyTwo =
      GoogleFonts.publicSans(fontWeight: FontWeight.w700, fontSize: 14);
  static final TextStyle kPublicBoldBodyThree =
      GoogleFonts.publicSans(fontWeight: FontWeight.w700, fontSize: 12);
  static final TextStyle kPublicBoldBodyFour =
      GoogleFonts.publicSans(fontWeight: FontWeight.w700, fontSize: 10);

  static final TextStyle kInterMediumBodyOne =
      GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 16);
}
