import 'package:bloc/bloc.dart';
import '../data/datasources/data_sources.dart';
import '../data/models/home/akademik_student_status_model.dart';
import '../data/models/home/student_body_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.dataSource) : super(HomeInitial());

  final DataSource dataSource;

  Future<void> getStudentBody() async {
    emit(StudentBodyLoading());
    final StudentBody studentBody = await dataSource.getStudentBody();
    emit(StudentBodyLoaded(studentBody.data));
  }

  Future<void> getStudentStatus() async {
    emit(AkademikStudentStatusLoading());
    final AkademikStudentStatus akademikStatus =
        await dataSource.getStudentStatus();
    emit(AkademikStudentStatusLoaded(akademikStatus.data));
  }

  //nonaktfikan sementara
  // Future<void> getExceptionForHomepage() async {
  //   emit(StudentBodyLoading());
  //   try {
  //     final data = await dataSource.getStudentBody();
  //     if (data.data == null) {
  //       emit(StudentBodyEmpty());
  //     } else {
  //       await Future.delayed(const Duration(seconds: 5));
  //       emit(StudentBodyLoaded(data.data));
  //     }
  //   } catch (e) {
  //     emit(StudentBodyError('Something Wrong'));
  //   }
  // }

  //experimen 1
  // Future<void> getExceptionForHomepage() async {
  //   emit(StudentBodyLoading());
  //   try {
  //     final data = dataSource.getStudentBody();
  //     final delayFuture = Future.delayed(const Duration(seconds: 5));
  //     final result = await Future.any([data, delayFuture]);
  //     if (result is StudentBody) {
  //       if (result.data == null) {
  //         emit(StudentBodyEmpty());
  //       } else {
  //         emit(StudentBodyLoaded(result.data));
  //       }
  //     } else {
  //        emit(StudentBodyEmpty());
  //     }
  //   } catch (e) {
  //     emit(StudentBodyError('Something Wrong'));
  //   }
  // }

  Future<void> getExceptionForHomepage() async {
    emit(StudentBodyLoading());
    try {
      final data = await dataSource.getStudentBody(); // Tunggu pengambilan data
      if (data.data == null) {
        emit(StudentBodyEmpty());
      } else {
        
        emit(StudentBodyLoaded(data.data));
      }
    } catch (e) {
      await Future.delayed(
          const Duration(seconds: 2)); // Delay 5 detik jika terjadi error
      emit(StudentBodyError('Something Wrong'));
    }
  }
}
