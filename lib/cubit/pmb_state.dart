part of 'pmb_cubit.dart';

@immutable
sealed class PmbState {}

final class PmbInitial extends PmbState {}

class RefFakultasLoading extends PmbState {}

class RefFakultasLoaded extends PmbState {
  final List<RefFak> data;
  RefFakultasLoaded(this.data);
}
