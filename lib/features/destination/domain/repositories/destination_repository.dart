import 'package:course_travel/core/error/failures.dart';
import 'package:course_travel/features/destination/domain/entities/DestinationEntity.dart';
import 'package:dartz/dartz.dart';

abstract class DestinationRepository {
  Future<Either<Failure, List<DestinationEntity>>> all();
  Future<Either<Failure, List<DestinationEntity>>> top();
  Future<Either<Failure, List<DestinationEntity>>> search(String query);
}
