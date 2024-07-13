import 'package:bloc/bloc.dart';
import 'package:des_uad/data/models/sdm/sdm_jabatan_fung_dosen_model.dart';
import 'package:des_uad/data/models/sdm/sdm_jabatan_fung_tendik_model.dart';
import 'package:des_uad/data/models/sdm/sdm_pendidikan_dosen_model.dart';
import 'package:meta/meta.dart';

import '../data/datasources/data_sources.dart';
import '../data/models/sdm/sdm_gender_dosen_model.dart';
import '../data/models/sdm/sdm_gender_tendik_model.dart';
import '../data/models/sdm/sdm_jumlah_dosen_model.dart';
import '../data/models/sdm/sdm_jumlah_tendik_model.dart';
import '../data/models/sdm/sdm_pendidikan_tendik_model.dart';
import '../data/models/sdm/sdm_persebaran_prodi_dosen_model.dart';

part 'sdm_state.dart';

class SdmCubit extends Cubit<SdmState> {
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
    final List<DataJabatanFungsionalTendik> dataJabfungTendik = await dataSource.getJabatanFungsionalTendik();
    emit(JabfungTendikLoaded(dataJabfungTendik));
  }

  Future<void> getPersebaranProdiDosen() async {
    final List<DataPersebaranProdiDosen> dataPersebaranProdiDosen = await dataSource.getPersebaranProdiDosen();
    emit(PersebaranProdiDosenLoaded(dataPersebaranProdiDosen));
  }


}
