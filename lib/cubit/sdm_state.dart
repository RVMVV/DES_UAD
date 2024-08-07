part of 'sdm_cubit.dart';

@immutable
sealed class SdmState {}

final class SdmInitial extends SdmState {}

final class SdmJumlah extends SdmState {}

final class SdmGender extends SdmState {}

final class SdmPendidikanDosen extends SdmState {}

final class SdmPendidikanTendik extends SdmState {}

final class SdmJabfungDosen extends SdmState {}

final class SdmJabfungTendik extends SdmState {}

final class SdmProdiDosen extends SdmState {}

final class SdmFakultasDosen extends SdmState {}

final class SdmPersebaranDosen extends SdmState {}

final class SdmPersebaranTendik extends SdmState {}

final class SdmDosenJabfung extends SdmState {}

//eksperimen
final class SdmDosenJabfungPagination extends SdmState {}

final class SdmJumlahDosenLoading extends SdmJumlah {}

final class SdmJumlahDosenLoaded extends SdmJumlah {
  final DataJumlahDosen data;
  SdmJumlahDosenLoaded(this.data);
}

final class SdmGenderDosenLoading extends SdmGender {}

final class SdmGenderDosenLoaded extends SdmGender {
  final DataGenderDosen data;
  SdmGenderDosenLoaded(this.data);
}

final class SdmJumlahTendikLoading extends SdmJumlah {}

final class SdmJumlahTendikLoaded extends SdmJumlah {
  final DataJumlahTendik data;
  SdmJumlahTendikLoaded(this.data);
}

final class SdmGenderTendikLoading extends SdmGender {}

final class SdmGenderTendikLoaded extends SdmGender {
  final DataGenderTendik data;
  SdmGenderTendikLoaded(this.data);
}

final class SdmJumlahDosenTendik extends SdmJumlah {
  final SdmJumlahDosen dataDosen;
  final SdmJumlahTendik dataTendik;

  SdmJumlahDosenTendik(this.dataDosen, this.dataTendik);
}

final class PendidikanDosenLoaded extends SdmPendidikanDosen {
  final List<DataPendidikanDosen> data;
  PendidikanDosenLoaded(this.data);
}

final class PendidikanTendikLoaded extends SdmPendidikanTendik {
  final List<DataPendidikanTendik> data;
  PendidikanTendikLoaded(this.data);
}

final class JabfungDosenLoaded extends SdmJabfungDosen {
  final List<DataJabatanFungsionalDosen> data;
  JabfungDosenLoaded(this.data);
}

final class JabfungTendikLoaded extends SdmJabfungTendik {
  final List<DataJabatanFungsionalTendik> data;
  JabfungTendikLoaded(this.data);
}

final class PersebaranProdiDosenLoaded extends SdmProdiDosen {
  final List<DataPersebaranProdiDosen> data;
  PersebaranProdiDosenLoaded(this.data);
}

final class PersebaranDosenProdiFakultasLoaded extends SdmPersebaranDosen {
  final List<PersebaranBerdasarkan> datas;
  PersebaranDosenProdiFakultasLoaded(this.datas);
}

final class PersebaranFakultasTendikLoading extends SdmPersebaranTendik {}

final class PersebaranFakultasTendikLoaded extends SdmPersebaranTendik {
  final List<PersebaranBerdasarkan> datas;
  PersebaranFakultasTendikLoaded(this.datas);
}

final class PersebaranProdiTendikLoading extends SdmPersebaranTendik {}

final class PersebaranProdiTendikLoaded extends SdmPersebaranTendik {
  final List<PersebaranProdi> datas;
  PersebaranProdiTendikLoaded(this.datas);
}

final class DosenJabfungLoading extends SdmDosenJabfung {}

final class DosenJabfungLoaded extends SdmDosenJabfung {
  final DosenJabfung datas;
  DosenJabfungLoaded(this.datas);
}

//eksperimen
final class DosenJabfungPaginationLoading extends SdmDosenJabfungPagination {}

final class DosenJabfungPaginationLoaded extends SdmDosenJabfungPagination {
  final List<Dosen> datas;
  final int currentPage;

  DosenJabfungPaginationLoaded(this.datas, this.currentPage);
}

final class DosenJabfungPaginationError extends SdmDosenJabfungPagination {
  final String error;

  DosenJabfungPaginationError(this.error);
}
