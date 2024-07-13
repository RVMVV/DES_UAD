part of 'mutu_cubit.dart';

@immutable
sealed class MutuState {}

final class MutuInitial extends MutuState {}

final class AppBarButtonClicked extends MutuState {}

final class ListViewButtonClicked extends MutuState {}

// Seksi Akreditasi
class Akreditasi extends MutuState {}

class AkreditasiTersertifikasi extends MutuState {}

// Total Prodi
class TotalProdiState extends Akreditasi {}

class TotalProdiLoading extends TotalProdiState {}

class TotalProdiLoaded extends TotalProdiState {
  final String data;

  TotalProdiLoaded(this.data);
}

// Persebaran Akreditasi Prodi
class PersebaranAkreditasiProdiState extends Akreditasi {}

class PersebaranAkreditasiProdiLoading extends PersebaranAkreditasiProdiState {}

class PersebaranAkreditasiProdiLoaded extends PersebaranAkreditasiProdiState {
  final List<PersebaranAkreditasi> datas;

  PersebaranAkreditasiProdiLoaded(this.datas);
}

// Akreditasi Internasional

// Sertifikasi Internasional

// Persebaran Akreditasi Internasional
class PersebaranAkreditasiInternasionalState extends Akreditasi {}

class PersebaranAkreditasiInternasionalLoading
    extends PersebaranAkreditasiInternasionalState {}

class PersebaranAkreditasiInternasionalLoaded
    extends PersebaranAkreditasiInternasionalState {
  final List<PersebaranAkreditasiInternasional> datas;

  PersebaranAkreditasiInternasionalLoaded(this.datas);
}

class AkreditasiPersebaranTersertifikasiProdiLoaded
    extends AkreditasiTersertifikasi {
  final List<DataSertifikasiProdi> data;
  AkreditasiPersebaranTersertifikasiProdiLoaded(this.data);
}

class AkreditasiProdiLoading extends Akreditasi {}

class AkreditasiProdiLoaded extends Akreditasi {
  final ProdiAkreditasi datas;
  AkreditasiProdiLoaded(this.datas);
}
