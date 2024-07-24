import 'dart:convert';
import 'package:http/http.dart';

import '../../core/constant_finals.dart';
import '../../core/failure/server_exception.dart';
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
import '../models/sdm/sdm_dosen_jabfung_model.dart';
import '../models/sdm/sdm_gender_dosen_model.dart';
import '../models/sdm/sdm_gender_tendik_model.dart';
import '../models/sdm/sdm_jabatan_fung_dosen_model.dart';
import '../models/sdm/sdm_jabatan_fung_tendik_model.dart';
import '../models/sdm/sdm_jumlah_dosen_model.dart';
import '../models/sdm/sdm_jumlah_tendik_model.dart';
import '../models/sdm/sdm_pendidikan_dosen_model.dart';
import '../models/sdm/sdm_pendidikan_tendik_model.dart';
import '../models/sdm/sdm_persebaran_prodi_dosen_model.dart';
import 'data_sources.dart';

class DataSourceImpl implements DataSource {
  @override
  Future<String> getJumlahMahasiswaLokal() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['mahasiswa_asing']['jumlah']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return decoded['data']['total_mhs'];
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<String> getJumlahMahasiswaAsing() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['mahasiswa_asing']['jumlah']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return decoded['data']['total_mhs'];
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranNegara>> getPersebaranNegara() async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['mahasiswa_asing']['persebaran_negara']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranNegara.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<DataPMB> getDataPMB() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['pmb']['dataPMB']}'));
      final decoded = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return DataPMB.fromJson(decoded['data']);
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranFakultas>> getPersebaranFakultasMahasiswaBaru() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['pmb']['persebaran_fakultas']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranFakultas.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranProvinsi>> getPersebaranProvinsiMahasiswaBaru() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['pmb']['persebaran_provinsi']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranProvinsi.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranProdi>> getPersebaranProdiMahasiswaBaru(
      String fakKode) async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['pmb']['persebaran_prodi']}?fak=$fakKode'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranProdi.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranFakultas>> getPmbRegulerFakultas() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['pmb']['persebaran_fakultas']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranFakultas.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranProdi>> getPmbRegulerProdi(String fakKode) async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['pmb']['persebaran_prodi']}?fak=$fakKode'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranProdi.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranFakultas>> getMhsLokalFakultas() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['pmb']['persebaran_fakultas']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranFakultas.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranProdi>> getMhsLokalProdi(String fakKode) async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['pmb']['persebaran_prodi']}?fak=$fakKode'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranProdi.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranFakultas>> getPmbNonRegulerFakultas() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['pmb']['persebaran_fakultas']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranFakultas.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranProdi>> getPmbNonRegulerProdi(String fakKode) async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['pmb']['persebaran_prodi']}?fak=$fakKode'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranProdi.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TrenKelulusan>> getTrenKelulusan() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['kelulusan']['tren']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => TrenKelulusan.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PerbandinganKelulusan>> getPerbandinganKelulusan() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['kelulusan']['perbandingan']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PerbandinganKelulusan.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<StudiMahasiswa> getStudiMahasiswa() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['keberhasilan']['mhs']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return StudiMahasiswa.fromJson(decoded['data']);
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PerbandinganKeberhasilanStudi>>
      getPerbandinganKeberhasilanStudi() async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['keberhasilan']['perbandingan']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PerbandinganKeberhasilanStudi.fromJson(e))
            .toList();
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Koleksi> getKoleksi() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['perpustakaan']['koleksi']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Koleksi.fromJson(decoded['data']);
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<String> getEksemplar() async {
    try {
      final response =
          await get(Uri.parse('$url${endpoint['perpustakaan']['eksemplar']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return decoded['data']['total_eksemplar'];
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<StudentBody> getStudentBody() async {
    try {
      final Response response =
          await get(Uri.parse('$url${endpoint['mahasiswa_status']['jumlah']}'));
      if (response.statusCode == 200) {
        return studentBodyFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<AkademikStudentStatus> getStudentStatus() async {
    try {
      final Response response =
          await get(Uri.parse('$url${endpoint['mahasiswa_status']['status']}'));
      if (response.statusCode == 200) {
        return akademikStudentStatusFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  //Sumber Daya Manusia
  @override
  Future<SdmJumlahDosen> getJumlahDosen() async {
    try {
      final Response response = await get(
          Uri.parse('$url${endpoint['sdm']['sdm_dosen']['ratio_jumlah']}'));
      if (response.statusCode == 200) {
        return sdmJumlahDosenFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<SdmJumlahTendik> getJumlahTendik() async {
    try {
      final Response response = await get(
          Uri.parse('$url${endpoint['sdm']['sdm_tendik']['ratio_jumlah']}'));
      if (response.statusCode == 200) {
        return sdmJumlahTendikFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<SdmGenderDosen> getGenderDosen() async {
    try {
      final Response response =
          await get(Uri.parse('$url${endpoint['sdm']['sdm_dosen']['gender']}'));
      if (response.statusCode == 200) {
        return sdmGenderDosenFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<SdmGenderTendik> getGenderTendik() async {
    try {
      final Response response = await get(
          Uri.parse('$url${endpoint['sdm']['sdm_tendik']['gender']}'));
      if (response.statusCode == 200) {
        return sdmGenderTendikFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<String> getTotalProdi() async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['mutu']['akreditasi']['total']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return decoded['data']['total_prodi'];
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranAkreditasi>> getPersebaranAkreditasi() async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['mutu']['akreditasi']['prodi']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranAkreditasi.fromJson(e))
            .toList();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<SertifikasiInternasional>> getSertifikasiInternasional() {
    throw UnimplementedError();
  }

  @override
  Future<List<PersebaranAkreditasiInternasional>>
      getPersebaranAkreditasInternasional() async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['mutu']['akreditasi']['internasional']}'));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decoded['data'] as List)
            .map((e) => PersebaranAkreditasiInternasional.fromJson(e))
            .toList();
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<DataPendidikanDosen>> getPendidikanDosen() async {
    try {
      final Response response = await get(
        Uri.parse('$url${endpoint['sdm']['sdm_dosen']['pendidikan']}'),
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((e) => DataPendidikanDosen.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<DataJabatanFungsionalDosen>> getJabatanFungsionalDosen() async {
    try {
      final Response response = await get(
          Uri.parse('$url${endpoint['sdm']['sdm_dosen']['fungsional']}'));
      if (response.statusCode == 200) {
        // print(response.body);
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((e) => DataJabatanFungsionalDosen.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<DataJabatanFungsionalTendik>> getJabatanFungsionalTendik() async {
    try {
      final Response response = await get(
          Uri.parse('$url${endpoint['sdm']['sdm_tendik']['fungsional']}'));
      if (response.statusCode == 200) {
        // print(response.body);
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data
            .map((e) => DataJabatanFungsionalTendik.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<DataPendidikanTendik>> getPendidikanTendik() async {
    try {
      final Response response = await get(
          Uri.parse('$url${endpoint['sdm']['sdm_tendik']['pendidikan']}'));
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((e) => DataPendidikanTendik.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<DataSertifikasiProdi>> getSertifikasiProdi() async {
    try {
      final Response response = await get(
          Uri.parse('$url${endpoint['mutu']['akreditasi']['sertifikasi']}'));
      if (response.statusCode == 200) {
        // print(response.body);
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((e) => DataSertifikasiProdi.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<DataPersebaranProdiDosen>> getPersebaranProdiDosen() async {
    try {
      final Response response = await get(
          Uri.parse('$url${endpoint['sdm']['sdm_dosen']['persebaran_prodi']}'));
      if (response.statusCode == 200) {
        // print(response.body);
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((e) => DataPersebaranProdiDosen.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranFakultas>> getPersebaranFakultasDosen() async {
    try {
      final Response response = await get(Uri.parse(
          '$url${endpoint['sdm']['sdm_dosen']['persebaran_fakultas']}'));
      if (response.statusCode == 200) {
        print(response.body);
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((e) => PersebaranFakultas.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProdiAkreditasi> getProdiAkreditasi() async {
    try {
      final response = await get(
          Uri.parse('$url${endpoint['mutu']['akreditasi']['akre_prodi']}'));
      if (response.statusCode == 200) {
        return prodiAkreditasiFromJson(response.body);
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<PrestasiMahasiswa> getPrestasiMahasiswa() async {
    try {
      final Response response =
          await get(Uri.parse('$url${endpoint['prestasi']['mahasiswa']}'));
      if (response.statusCode == 200) {
        return prestasiMahasiswaFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<RefFak>> refFakultas() async {
    try {
      final Response response =
          await get(Uri.parse('$url${endpoint['general']['ref_fakultas']}'));
      if (response.statusCode == 200) {
        // print(response.body);
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((e) => RefFak.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PersebaranProdi>> getPersebaranDosenProdiBerdasarkanFakultas(
      String fakKode) async {
    try {
      final Response response = await get(Uri.parse(
          '$url${endpoint['sdm']['sdm_dosen']['persebaran_prodi']}?fak=$fakKode'));
      if (response.statusCode == 200) {
        // print(response.body);
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((e) => PersebaranProdi.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<DosenJabfung> getDosenJabfung(String jabf) async {
    try {
      final response = await get(Uri.parse(
          '$url${endpoint['sdm']['sdm_dosen']['dosen_jabfung']}?jabfung=$jabf'));
      if (response.statusCode == 200) {
        print(response.body);
        return dosenJabfungFromJson(response.body);
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
