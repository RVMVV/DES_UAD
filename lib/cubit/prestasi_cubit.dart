import 'package:bloc/bloc.dart';
import '../data/datasources/data_sources.dart';
import 'package:meta/meta.dart';

import '../data/models/prestasi/prestasi_mahasiswa_model.dart';

part 'prestasi_state.dart';

class PrestasiCubit extends Cubit<PrestasiState> {
  PrestasiCubit({required this.dataSource}) : super(PrestasiInitial());

  final DataSource dataSource;

  bool isNasional = true;
  int index = 0;

  void clickCakupanPrestasiButton({final bool isActive = true}) {
    isNasional = isActive;
    emit(CakupanPrestasiButtonClicked());
  }

  Future<void> getPrestasiMahasiswa() async {
    emit(PrestasiMahasiswaLoading());
    final PrestasiMahasiswa data = await dataSource.getPrestasiMahasiswa();
    emit(PrestasiMahasiswaLoaded(data.data));
  }
}
