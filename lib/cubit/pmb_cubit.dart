import 'package:bloc/bloc.dart';
import '../data/datasources/data_sources.dart';
import 'package:meta/meta.dart';

import '../data/models/akademik/ref_fakultas_model.dart';

part 'pmb_state.dart';

class PmbCubit extends Cubit<PmbState> {
  PmbCubit({required this.dataSource}) : super(PmbInitial());

  final DataSource dataSource;

  Future<void> getRefFakultas() async {
    emit(RefFakultasLoading());
    final result = await dataSource.refFakultas();
    // print('result');
    // print(result);
    emit(RefFakultasLoaded(result));
    // print('yooow');
  }
}
