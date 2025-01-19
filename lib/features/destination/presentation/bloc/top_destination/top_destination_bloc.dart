import 'package:course_travel/features/destination/domain/entities/DestinationEntity.dart';
import 'package:course_travel/features/destination/domain/usecases/get_top_destination_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_destination_event.dart';
part 'top_destination_state.dart';

class TopDestinationBloc
    extends Bloc<TopDestinationEvent, TopDestinationState> {
  final GetTopDestinationUsecase _usecase;

  TopDestinationBloc(this._usecase) : super(TopDestinationInitial()) {
    on<OnGetTopDestination>((event, emit) async {
      emit(TopDestinationLoading());
      final result = await _usecase();
      result.fold((failure) => emit(TopDestinationFailure(failure.message)),
          (data) => emit(TopDestinationLoaded(data)));
    });
  }
}
