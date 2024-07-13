import 'package:bloc/bloc.dart';
import 'package:des_uad/data/datasources/data_sources.dart';
import 'package:meta/meta.dart';

import '../data/models/sdm/sdm_persebaran_prodi_dosen_model.dart';

part 'sdm_pre_state.dart';

class SdmPreCubit extends Cubit<SdmPreState> {
  SdmPreCubit(this.dataSource) : super(SdmPreInitial());

  final DataSource dataSource;

    Future<void> getPersebaranFakultasDosen() async {
    final List<DataPersebaranProdiDosen> dataPersebaranFakultasDosen = await dataSource.getPersebaranFakultasDosen();
    emit(PersebaranFakultasDosenLoaded(dataPersebaranFakultasDosen));
  }
}
