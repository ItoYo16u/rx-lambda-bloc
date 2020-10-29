import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

abstract class InitializeMiddeware {
  Future<Either<Failure,Unit>> init();
}