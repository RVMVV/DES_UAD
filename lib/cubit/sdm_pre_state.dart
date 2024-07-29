part of 'sdm_pre_cubit.dart';

@immutable
sealed class SdmPreState {}

final class SdmPreInitial extends SdmPreState {}

final class SdmPersebaran extends SdmPreState {}

final class PersebaranFakultasDosen extends SdmPersebaran {}


final class PersebaranFakultasDosenLoaded extends PersebaranFakultasDosen {
  final List<PersebaranBerdasarkan> datas;
  PersebaranFakultasDosenLoaded(this.datas);
}
