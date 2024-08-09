import 'package:bloc/bloc.dart';
import 'package:des_uad/core/failure/server_exception.dart';
import 'package:des_uad/data/models/sdm/sdm_jabatan_fung_dosen_model.dart';
import 'package:des_uad/data/models/sdm/sdm_jabatan_fung_tendik_model.dart';
import 'package:des_uad/data/models/sdm/sdm_pendidikan_dosen_model.dart';
import 'package:meta/meta.dart';

import '../data/datasources/data_sources.dart';
import '../data/models/akademik/penerimaan_mahasiswa_baru/persebaran_prodi.dart';
import '../data/models/persebaran_berdasarkan.dart';
import '../data/models/sdm/sdm_dosen_jabfung_model.dart';
import '../data/models/sdm/sdm_gender_dosen_model.dart';
import '../data/models/sdm/sdm_gender_tendik_model.dart';
import '../data/models/sdm/sdm_jumlah_dosen_model.dart';
import '../data/models/sdm/sdm_jumlah_tendik_model.dart';
import '../data/models/sdm/sdm_pendidikan_tendik_model.dart';
import '../data/models/sdm/sdm_persebaran_prodi_dosen_model.dart';

part 'sdm_state.dart';

class SdmCubit extends Cubit<SdmState> {
  //eksperimen
  List<Dosen> _allDosen = [];
  int _currentPage = 1;

  SdmCubit(this.dataSource) : super(SdmInitial());

  final DataSource dataSource;

  //dosen
  Future<void> getJumlahDosen() async {
    emit(SdmJumlahDosenLoading());

    final SdmJumlahDosen data = await dataSource.getJumlahDosen();
    emit(SdmJumlahDosenLoaded(data.data));
  }

  Future<void> getGenderDosen() async {
    emit(SdmGenderDosenLoading());

    final SdmGenderDosen data = await dataSource.getGenderDosen();
    emit(SdmGenderDosenLoaded(data.data));
  }

  //tendik
  Future<void> getJumlahTendik() async {
    emit(SdmJumlahTendikLoading());

    final SdmJumlahTendik data = await dataSource.getJumlahTendik();
    emit(SdmJumlahTendikLoaded(data.data));
  }

  Future<void> getGenderTendik() async {
    emit(SdmGenderTendikLoading());

    final SdmGenderTendik data = await dataSource.getGenderTendik();
    emit(SdmGenderTendikLoaded(data.data));
  }

  Future<void> getJumlahDosenTendik() async {
    final SdmJumlahDosen dataDosen = await dataSource.getJumlahDosen();
    final SdmJumlahTendik dataTendik = await dataSource.getJumlahTendik();
    emit(SdmJumlahDosenTendik(dataDosen, dataTendik));
  }

  Future<void> getPendidikanDosen() async {
    final List<DataPendidikanDosen> dataPendidikanDosen =
        await dataSource.getPendidikanDosen();
    emit(PendidikanDosenLoaded(dataPendidikanDosen));
  }

  Future<void> getPendidikanTendik() async {
    final List<DataPendidikanTendik> dataPendidikanTendik =
        await dataSource.getPendidikanTendik();
    emit(PendidikanTendikLoaded(dataPendidikanTendik));
  }

  Future<void> getJabfungDosen() async {
    final List<DataJabatanFungsionalDosen> dataJabfungDosen =
        await dataSource.getJabatanFungsionalDosen();
    emit(JabfungDosenLoaded(dataJabfungDosen));
  }

  Future<void> getJabfungTendik() async {
    final List<DataJabatanFungsionalTendik> dataJabfungTendik =
        await dataSource.getJabatanFungsionalTendik();
    emit(JabfungTendikLoaded(dataJabfungTendik));
  }

  Future<void> getPersebaranProdiDosen() async {
    final List<DataPersebaranProdiDosen> dataPersebaranProdiDosen =
        await dataSource.getPersebaranProdiDosen();
    emit(PersebaranProdiDosenLoaded(dataPersebaranProdiDosen));
  }

  Future<void> getPersebaranFakultasTendik() async {
    emit(PersebaranFakultasTendikLoading());
    final result = await dataSource.getPersebaranFakultasTendik();
    emit(PersebaranFakultasTendikLoaded(result));
  }

  Future<void> getPersebaranProdiTendikBerdasarkanFakultas(
      String fakKode) async {
    emit(PersebaranProdiTendikLoading());
    final result =
        await dataSource.getPersebaranProdiTendikBerdasarkanFakultas(fakKode);
    emit(PersebaranProdiTendikLoaded(result));
  }

  Future<void> getPersebaranDosenProdiBerdasarkanFakultas(
      String fakKode) async {
    final result =
        await dataSource.getPersebaranDosenProdiBerdasarkanFakultas(fakKode);
    emit(PersebaranDosenProdiFakultasLoaded(result));
  }

  Future<void> getDosenJabfung(String jabfung) async {
    emit(DosenJabfungLoading());
    final result = await dataSource.getDosenJabfung(jabfung);
    emit(DosenJabfungLoaded(result));
  }

  //nonaktif sementara
  // Future<void> getDosenJabfungPagination(String jabfung, int pageNum) async {
  //   emit(DosenJabfungLoading());
  //   final result = await dataSource.getDosenJabfungPagination(jabfung, pageNum);
  //   emit(DosenJabfungLoaded(result));

  // }

  //eksperimen - it works but need some works - non active temporary
  Future<void> getDosenJabfungPagination(String jabfung, int pageNum) async {
    emit(DosenJabfungPaginationLoading());
    try {
      final response =
          await dataSource.getDosenJabfungPagination(jabfung, pageNum);
      // Parse response to model
      final DosenJabfung data = response;

      if (pageNum == 1) {
        // Jika ini adalah halaman pertama, reset list data
        _allDosen = data.data;  
      } else {
        // Tambahkan data dari halaman berikutnya ke list yang sudah ada
        _allDosen.addAll(data.data);
      }
      _currentPage = pageNum;
      emit(DosenJabfungPaginationLoaded(_allDosen, _currentPage));
    } catch (e) {
      print('something wrong ${e.toString()}');
      emit(DosenJabfungPaginationError(e.toString()));
    }
  }

  // Future<void> getDosenJabfungPagination(String jabfung, int pageNum) async {
  //   if (_currentPage == pageNum) return; // Avoid reloading the same page

  //   emit(DosenJabfungPaginationLoading());
  //   try {
  //     final response = await dataSource.getDosenJabfungPagination(jabfung, pageNum);
  //     final data = response.data as List;
  //     List<Dosen> newDosenList = data.map((item) => Dosen.fromJson(item)).toList();

  //     _allDosen.addAll(newDosenList); // Add new data to the list
  //     _currentPage = pageNum;

  //     emit(DosenJabfungPaginationLoaded(_allDosen, _currentPage));
  //   } catch (e) {
  //     print('something wrong ${e.toString()}');
  //     emit(DosenJabfungPaginationError(e.toString()));
  //   }
  // }
}
