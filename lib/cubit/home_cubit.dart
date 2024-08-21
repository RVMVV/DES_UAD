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

  Future<void> getExceptionForHomepage() async {
    emit(StudentBodyLoading());
    try {
      final data = await dataSource.getStudentBody();
      if(data.status != 200) {
        emit(StudentBodyEmpty());
      }else{
        emit(StudentBodyLoaded(data.data));
      }
    } catch (e) {
      emit(StudentBodyError('Something Wrong'));
    }

    }
  }
