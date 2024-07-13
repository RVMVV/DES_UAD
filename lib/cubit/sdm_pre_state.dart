part of 'sdm_pre_cubit.dart';

@immutable
sealed class SdmPreState {}

final class SdmPreInitial extends SdmPreState {}

final class SdmPersebaranFakultas extends SdmPreState {}
final class PersebaranFakultasDosenLoaded extends SdmPersebaranFakultas {
  final List<DataPersebaranProdiDosen> data; // <--- nantinya akan diganti sesuai dengan class model yang sesuai
  //untuk saat ini memakai dari persebaranprodi, nanti diganti pakai persebaranfakultas model.
  PersebaranFakultasDosenLoaded(this.data);
}