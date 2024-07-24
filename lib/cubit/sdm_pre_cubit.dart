import 'package:bloc/bloc.dart';
import 'package:des_uad/data/datasources/data_sources.dart';
import 'package:des_uad/data/models/persebaran_berdasarkan.dart';
import 'package:meta/meta.dart';


part 'sdm_pre_state.dart';

class SdmPreCubit extends Cubit<SdmPreState> {
  SdmPreCubit(this.dataSource) : super(SdmPreInitial());

  final DataSource dataSource;

    Future<void> getPersebaranFakultasDosen() async {
    final result = await dataSource.getPersebaranFakultasDosen();
    emit(PersebaranFakultasDosenLoaded(result));
  }
}
