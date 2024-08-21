part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class StudentBodyState extends HomeState {}

class StudentStatusState extends HomeState {}

final class StudentBodyLoading extends StudentBodyState {}
final class StudentBodyLoaded extends StudentBodyState {
  final DataStudent data;
  StudentBodyLoaded(this.data);
}
final class StudentBodyEmpty extends StudentBodyState{}

final class StudentBodyError extends StudentBodyState {
  final String message;
  StudentBodyError(this.message);
}


final class AkademikStudentStatusLoading extends StudentStatusState {}
final class AkademikStudentStatusLoaded extends StudentStatusState {
  final DataStudentStatus data;
  AkademikStudentStatusLoaded(this.data);
}