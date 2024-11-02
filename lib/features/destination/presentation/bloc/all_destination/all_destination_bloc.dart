import 'package:course_travel/core/error/failures.dart';
import 'package:course_travel/features/destination/domain/entities/destinationEntity.dart';
import 'package:course_travel/features/destination/domain/usecases/get_all_destination_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_destination_event.dart';
part 'all_destination_state.dart';

class AllDestinationBloc
    extends Bloc<AllDestinationEvent, AllDestinationState> {
  final GetAllDestinationUsecase _usecase;
  AllDestinationBloc(this._usecase) : super(AllDestinationInitial()) {
    on<OnGetAllDestination>((event, emit) async {
      emit(AllDestinationLoading());
      final result = await _usecase();
      result.fold(
          (Failure failure) => emit(AllDestinationFailure(failure.message)),
          (data) => emit(AllDestinationLoaded(data)));
    });
  }
}
