import 'package:college_diary/core/failure.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef Futureeither = FutureEither<void>;
