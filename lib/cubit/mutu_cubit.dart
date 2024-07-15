import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/datasources/data_sources.dart';
import '../data/models/mutu/persebaran_akreditasi.dart';
import '../data/models/mutu/persebaran_akreditasi_internasional.dart';
import '../data/models/mutu/prodi_akreditasi.dart';
import '../data/models/mutu/sertifikasi_prodi_model.dart';

part 'mutu_state.dart';

class MutuCubit extends Cubit<MutuState> {
  MutuCubit({required this.dataSource}) : super(MutuInitial());

  final DataSource dataSource;

  bool isAkreditasi = true;
  int index = 0;

  void clickAppBarButton({final bool isActive = true}) {
    isAkreditasi = isActive;
    emit(AppBarButtonClicked());
  }

  void clickListViewButton(final int index) {
    this.index = index;
    emit(ListViewButtonClicked());
  }

  // Akreditasi
  Future<void> getTotalProdi() async {
    emit(TotalProdiLoading());

    final result = await dataSource.getTotalProdi();

    emit(TotalProdiLoaded(result));
  }

  Future<void> getAkreditasiProdi() async {
    emit(PersebaranAkreditasiProdiLoading());

    final result = await dataSource.getPersebaranAkreditasi();

    emit(PersebaranAkreditasiProdiLoaded(result));
  }

  Future<void> getAkreditasiInternasional() async {
    emit(PersebaranAkreditasiInternasionalLoading());

    final result = await dataSource.getPersebaranAkreditasInternasional();

    emit(PersebaranAkreditasiInternasionalLoaded(result));
  }

  Future<void> getSertifikasiProdi() async {
    final List<DataSertifikasiProdi> dataSertifikasiProdi =
        await dataSource.getSertifikasiProdi();
    emit(AkreditasiPersebaranTersertifikasiProdiLoaded(dataSertifikasiProdi));
  }

  Future<void> getProdiByAkreditasi() async {
    emit(AkreditasiProdiLoading());
    final result = await dataSource.getProdiAkreditasi();
    emit(AkreditasiProdiLoaded(result));
  }
}
