import '../models/akademik/keberhasilan_studi/perbandingan_keberhasilan_studi.dart';
import '../models/akademik/keberhasilan_studi/studi_mahasiswa.dart';
import '../models/akademik/kelulusan/perbandingan_kelulusan.dart';
import '../models/akademik/kelulusan/tren_kelulusan.dart';
import '../models/akademik/mahasiswa_asing/persebaran_negara.dart';
import '../models/akademik/penerimaan_mahasiswa_baru/data_pmb.dart';
import '../models/akademik/penerimaan_mahasiswa_baru/persebaran_fakultas.dart';
import '../models/akademik/penerimaan_mahasiswa_baru/persebaran_prodi.dart';
import '../models/akademik/penerimaan_mahasiswa_baru/persebaran_provinsi.dart';
import '../models/akademik/perpustakaan/koleksi.dart';
import '../models/akademik/ref_fakultas_model.dart';
import '../models/home/akademik_student_status_model.dart';
import '../models/home/student_body_model.dart';
import '../models/mutu/persebaran_akreditasi.dart';
import '../models/mutu/persebaran_akreditasi_internasional.dart';
import '../models/mutu/prodi_akreditasi.dart';
import '../models/mutu/sertifikasi_internasional.dart';
import '../models/mutu/sertifikasi_prodi_model.dart';
import '../models/prestasi/prestasi_mahasiswa_model.dart';
import '../models/sdm/sdm_gender_dosen_model.dart';
import '../models/sdm/sdm_gender_tendik_model.dart';
import '../models/sdm/sdm_jabatan_fung_dosen_model.dart';
import '../models/sdm/sdm_jabatan_fung_tendik_model.dart';
import '../models/sdm/sdm_jumlah_dosen_model.dart';
import '../models/sdm/sdm_jumlah_tendik_model.dart';
import '../models/sdm/sdm_pendidikan_dosen_model.dart';
import '../models/sdm/sdm_pendidikan_tendik_model.dart';
import '../models/sdm/sdm_persebaran_prodi_dosen_model.dart';

abstract interface class DataSource {
  // Referensi - Fakultas

  Future<List<RefFak>> refFakultas();

  // Akademik - Mahasiswa Asing
  Future<String> getJumlahMahasiswaAsing();
  Future<List<PersebaranNegara>> getPersebaranNegara();
  // Akademik - PMB
  Future<DataPMB> getDataPMB();
  Future<List<PersebaranFakultas>> getPersebaranFakultasMahasiswaBaru();
  Future<List<PersebaranProvinsi>> getPersebaranProvinsiMahasiswaBaru();
  Future<List<PersebaranProdi>> getPersebaranProdiMahasiswaBaru(String fak);

  Future<List<PersebaranFakultas>> getPmbRegulerFakultas();
  Future<List<PersebaranProdi>> getPmbRegulerProdi(String fak);

  Future<List<PersebaranFakultas>> getPmbNonRegulerFakultas();
  Future<List<PersebaranProdi>> getPmbNonRegulerProdi(String fak);

  // Akademik - Kelulusan
  Future<List<TrenKelulusan>> getTrenKelulusan();
  Future<List<PerbandinganKelulusan>> getPerbandinganKelulusan();
  // Akademik - Keberhasilan Studi
  Future<StudiMahasiswa> getStudiMahasiswa();
  Future<List<PerbandinganKeberhasilanStudi>>
      getPerbandinganKeberhasilanStudi();
  // Akademik - Perpustakaan
  Future<Koleksi> getKoleksi();
  Future<String> getEksemplar();
  // Home - Student Body
  Future<StudentBody> getStudentBody();
  Future<AkademikStudentStatus> getStudentStatus();

  // SDM - Jumlah Dosen
  Future<SdmJumlahDosen> getJumlahDosen();
  //SDM - Jumlah Tendik
  Future<SdmJumlahTendik> getJumlahTendik();
  //SDM - Gender Dosen
  Future<SdmGenderDosen> getGenderDosen();
  //SDM - Gender Tendik
  Future<SdmGenderTendik> getGenderTendik();
  //SDM - Jabatan Fungsional Dosen
  Future<List<DataJabatanFungsionalDosen>> getJabatanFungsionalDosen();
  //SDM - Jabatan Fungsional Tendik
  Future<List<DataJabatanFungsionalTendik>> getJabatanFungsionalTendik();
  //SDM - SDM Pendidikan Dosen
  Future<List<DataPendidikanDosen>> getPendidikanDosen();
  //SDM - SDM Pendidikan Tendik
  Future<List<DataPendidikanTendik>> getPendidikanTendik();
  //SDM - Persebaran Prodi Dosen
  Future<List<DataPersebaranProdiDosen>> getPersebaranProdiDosen();
  //SDM - Persebaran Fakultas Dosen
  Future<List<DataPersebaranProdiDosen>>
      getPersebaranFakultasDosen(); //   <-- class dalam list nantinya akan diganti, sementara pakai model class dari persebaran prodi

  // Mutu - Akreditasi
  Future<String> getTotalProdi();
  Future<List<PersebaranAkreditasi>> getPersebaranAkreditasi();

  //Mutu - Akreditasi Sertifikasi Prodi
  Future<List<DataSertifikasiProdi>> getSertifikasiProdi();

  /// Future<List<T>> getAkreditasiInternasional() -> Not Yet Aired
  Future<List<SertifikasiInternasional>> getSertifikasiInternasional();
  Future<List<PersebaranAkreditasiInternasional>>
      getPersebaranAkreditasInternasional();

  Future<ProdiAkreditasi> getProdiAkreditasi();
  Future<PrestasiMahasiswa> getPrestasiMahasiswa();
}
