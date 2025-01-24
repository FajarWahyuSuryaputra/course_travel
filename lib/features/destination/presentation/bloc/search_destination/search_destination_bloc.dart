import 'package:course_travel/features/destination/domain/entities/DestinationEntity.dart';
import 'package:course_travel/features/destination/domain/usecases/search_destination_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_destination_event.dart';
part 'search_destination_state.dart';

class SearchDestinationBloc
    extends Bloc<SearchDestinationEvent, SearchDestinationState> {
  final SearchDestinationUsecase _usecase;
  SearchDestinationBloc(this._usecase) : super(SearchDestinationInitial()) {
    on<OnSearchDestination>((event, emit) async {
      emit(SearchDestinationLoading());
      final result = await _usecase(query: event.query);
      result.fold((failure) => emit(SearchDestinationFailure(failure.message)),
          (data) => emit(SearchDestinationLoaded(data)));
    });
    on<OnResetSearchDestination>((event, emit) async {
      emit(SearchDestinationInitial());
    });
  }
}
