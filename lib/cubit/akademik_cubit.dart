import 'package:bloc/bloc.dart';
import '../data/datasources/data_sources.dart';
import '../data/models/akademik/keberhasilan_studi/perbandingan_keberhasilan_studi.dart';
import '../data/models/akademik/keberhasilan_studi/studi_mahasiswa.dart';
import '../data/models/akademik/kelulusan/perbandingan_kelulusan.dart';
import '../data/models/akademik/kelulusan/tren_kelulusan.dart';
import '../data/models/akademik/mahasiswa_asing/persebaran_negara.dart';
import '../data/models/akademik/penerimaan_mahasiswa_baru/data_pmb.dart';
import '../data/models/akademik/perpustakaan/koleksi.dart';
import '../data/models/persebaran_berdasarkan.dart';
import 'package:meta/meta.dart';

part 'akademik_state.dart';

enum JenisPMB { persebaran, reguler, nonReguler }

class AkademikCubit extends Cubit<AkademikState> {
  AkademikCubit({required this.dataSource}) : super(AkademikInitial());

  final DataSource dataSource;

  final List<int> indexJenisPMB = [0, 0, 0];
  List<bool> isChecked = [true, true, true, true];
  int indexMhsLokal = 0;
  int indexMhsAsing = 0;

  bool isActivated(final JenisPMB jenisPMB, final int index) =>
      indexJenisPMB[jenisPMB.index] == index;

  void clickActiveButtonPMB(final JenisPMB jenisPMB, final int index) {
    indexJenisPMB[jenisPMB.index] = index;
    emit(AkademikInitial());
  }

  void check(final int index) {
    isChecked[index] = !isChecked[index];
    emit(AkademikInitial());
  }

  void clickActiveButtonMhsLokal(final int index) {
    indexMhsLokal = index;
    emit(AkademikInitial());
  }

  void clickActiveButtonMhsAsing(final int index) {
    indexMhsAsing = index;
    emit(AkademikInitial());
  }

  // Mahasiswa Asing
  Future<void> getJumlahMahasiswaAsing() async {
    emit(JumlahMahasiswaAsingLoading());

    final result = await dataSource.getJumlahMahasiswaAsing();

    emit(JumlahMahasiswaAsingLoaded(result));
  }

  Future<void> getPersebaranNegara() async {
    emit(PersebaranNegaraMahasiswaAsingLoading());

    final result = await dataSource.getPersebaranNegara();

    emit(PersebaranNegaraMahasiswaAsingLoaded(result));
  }

  // PMB
  Future<void> getDataPMB() async {
    emit(DataPMBLoading());

    final result = await dataSource.getDataPMB();

    emit(DataPMBLoaded(result));
  }

  Future<void> getPersebaranPMB(JenisPMB jenisPMB, int index) async {
    indexJenisPMB[jenisPMB.index] = index;
    emit(PersebaranPMBLoading());

    switch (index) {
      case 0:
        final result = await dataSource.getPersebaranFakultasMahasiswaBaru();
        emit(PersebaranPMBLoaded(result));
        break;
      case 1:
        // Persebaran Prodi
        break;
      case 2:
        final result = await dataSource.getPersebaranProvinsiMahasiswaBaru();
        emit(PersebaranPMBLoaded(result));
        break;
      default:
    }
  }

  Future<void> getPersebaranPMBProdi(String fakultas) async {
    emit(PersebaranPMBLoading());
    final result = await dataSource.getPersebaranProdiMahasiswaBaru();
    emit(PersebaranPMBLoaded(result));
  }

  // Kelulusan Studi
  Future<void> getTrenKelulusan() async {
    emit(TrenKelulusanLoading());

    final result = await dataSource.getTrenKelulusan();

    emit(TrenKelulusanLoaded(result));
  }

  Future<void> getPerbandinganKelulusan() async {
    emit(PerbandinganKelulusanLoading());

    final result = await dataSource.getPerbandinganKelulusan();

    emit(PerbandinganKelulusanLoaded(result));
  }

  // Keberhasilan Studi
  Future<void> getStudiMahasiswa() async {
    emit(StudiMahasiswaLoading());

    final result = await dataSource.getStudiMahasiswa();

    emit(StudiMahasiswaLoaded(result));
  }

  Future<void> getPerbandinganKeberhasilanStudi() async {
    emit(PerbandinganKeberhasilanLoading());

    final result = await dataSource.getPerbandinganKeberhasilanStudi();

    emit(PerbandinganKeberhasilanLoaded(result));
  }

  // Perpustakaan
  Future<void> getKoleksi() async {
    emit(KoleksiLoading());
    final result = await dataSource.getKoleksi();
    emit(KoleksiLoaded(result));
  }

  Future<void> getEksemplar() async {
    emit(EksamplarLoading());
    final result = await dataSource.getEksemplar();
    emit(EksamplarLoaded(result));
  }
}
