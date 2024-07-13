part of 'prestasi_cubit.dart';

@immutable
sealed class PrestasiState {}

final class PrestasiInitial extends PrestasiState {}

class CakupanPrestasiButtonClicked extends PrestasiState{}


  class PrestasiMahasiswaLoading extends PrestasiState {}
  class PrestasiMahasiswaLoaded extends PrestasiState {
    final List<DataPrestasiMhs> data;
    PrestasiMahasiswaLoaded(this.data);
  }
