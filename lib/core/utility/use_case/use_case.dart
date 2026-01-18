import 'package:dartz/dartz.dart';
import 'package:meal_planner/core/utility/errors/failures.dart';
// clean architecture use case class
abstract class UseCase<Type,Param> {

  Future<Either<Failure, Type>> call([Param params]);
}
class NoParams {}
