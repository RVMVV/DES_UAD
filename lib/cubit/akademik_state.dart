part of 'akademik_cubit.dart';

@immutable
sealed class AkademikState {}

final class AkademikInitial extends AkademikState {}

// Mahasiswa Asing
class MahasiswaAsing extends AkademikState {}

class JumlahMahasiswaLokal extends MahasiswaAsing {}

class JumlahMahasiswaLokalLoading extends JumlahMahasiswaLokal {}

class JumlahMahasiswaLokalLoaded extends JumlahMahasiswaLokal {
  final String jumlah;

  JumlahMahasiswaLokalLoaded(this.jumlah);
}

class JumlahMahasiswaAsing extends MahasiswaAsing {}

class JumlahMahasiswaAsingLoading extends JumlahMahasiswaAsing {}

class JumlahMahasiswaAsingLoaded extends JumlahMahasiswaAsing {
  final String jumlah;

  JumlahMahasiswaAsingLoaded(this.jumlah);
}

class PersebaranNegaraMahasiswaAsing extends MahasiswaAsing {}

class PersebaranNegaraMahasiswaAsingLoading
    extends PersebaranNegaraMahasiswaAsing {}

class PersebaranNegaraMahasiswaAsingLoaded
    extends PersebaranNegaraMahasiswaAsing {
  final List<PersebaranNegara> persebaranNegara;

  PersebaranNegaraMahasiswaAsingLoaded(this.persebaranNegara);
}

// Penerimaan Mahasiswa Baru
class PMB extends AkademikState {}

// Data PMB
class DataPMBState extends PMB {}

class DataPMBLoading extends DataPMBState {}

class DataPMBLoaded extends DataPMBState {
  final DataPMB data;
  final List<Waktu> tren;
  DataPMBLoaded(this.data, this.tren);
}

// Persebaran PMB
class PersebaranPMBState extends PMB {}

class PersebaranPMBLoading extends PersebaranPMBState {}

class PersebaranPMBLoaded extends PersebaranPMBState {
  final List<PersebaranBerdasarkan> datas;

  PersebaranPMBLoaded(this.datas);
}

// Kelulusan
class Kelulusan extends AkademikState {}

// Tren Kelulusan
class TrenKelulusanState extends Kelulusan {}

class TrenKelulusanLoading extends TrenKelulusanState {}

class TrenKelulusanLoaded extends TrenKelulusanState {
  final List<TrenKelulusan> datas;

  TrenKelulusanLoaded(this.datas);
}

// Perbandingan Kelulusan
class PerbandinganKelulusanState extends Kelulusan {}

class PerbandinganKelulusanLoading extends PerbandinganKelulusanState {}

class PerbandinganKelulusanLoaded extends PerbandinganKelulusanState {
  final List<PerbandinganKelulusan> datas;

  PerbandinganKelulusanLoaded(this.datas);
}

// Keberhasilan Studi
class Keberhasilan extends AkademikState {}

// Studi Mahasiswa
class StudiMahasiswaState extends Keberhasilan {}

class StudiMahasiswaLoading extends StudiMahasiswaState {}

class StudiMahasiswaLoaded extends StudiMahasiswaState {
  final StudiMahasiswa data;

  StudiMahasiswaLoaded(this.data);
}

// Tren Keberhasilan Studi (Not Yet Aired)

// Perbandingan Keberhasilan Studi
class PerbandinganKeberhasilanState extends Keberhasilan {}

class PerbandinganKeberhasilanLoading extends PerbandinganKeberhasilanState {}

class PerbandinganKeberhasilanLoaded extends PerbandinganKeberhasilanState {
  final List<PerbandinganKeberhasilanStudi> datas;

  PerbandinganKeberhasilanLoaded(this.datas);
}

// Perpustakaan
class Perpustakaan extends AkademikState {}

// Koleksi
class KoleksiState extends Perpustakaan {}

class KoleksiLoading extends KoleksiState {}

class KoleksiLoaded extends KoleksiState {
  final Koleksi data;

  KoleksiLoaded(this.data);
}

// Eksamplar
class EksamplarState extends Perpustakaan {}

class EksamplarLoading extends EksamplarState {}

class EksamplarLoaded extends EksamplarState {
  final String data;

  EksamplarLoaded(this.data);
}

// Jalur Reg
class PmbJalurRegState extends PMB {}

class PmbJalurRegLoading extends PmbJalurRegState {}

class PmbJalurRegLoaded extends PmbJalurRegState {
  final List<PersebaranBerdasarkan> datas;
  PmbJalurRegLoaded(this.datas);
}

// Jalur Non Reg
class PmbJalurNonRegState extends PMB {}

class PmbJalurNonRegLoading extends PmbJalurNonRegState {}

class PmbJalurNonRegLoaded extends PmbJalurNonRegState {
  final List<PersebaranBerdasarkan> datas;
  PmbJalurNonRegLoaded(this.datas);
}

// Mahasiswa Lokal
class MhsLokalState extends PMB {}

class MhsLokalLoading extends MhsLokalState {}

class MhsLokalLoaded extends MhsLokalState {
  final List<PersebaranBerdasarkan> datas;
  MhsLokalLoaded(this.datas);
}

// Tren Pmb Harian
class TrenPmbHarianState extends PMB {}

class TrenPmbHarianLoading extends TrenPmbHarianState {}

class TrenPmbHarianLoaded extends TrenPmbHarianState {
  final List<Waktu> datas;
  TrenPmbHarianLoaded(this.datas);
}
