import 'package:course_travel/core/error/failures.dart';
import 'package:course_travel/features/destination/domain/entities/destinationEntity.dart';
import 'package:course_travel/features/destination/domain/repositories/destination_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllDestinationUsecase {
  final DestinationRepository _repository;

  GetAllDestinationUsecase(this._repository);
  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.all();
  }
}
