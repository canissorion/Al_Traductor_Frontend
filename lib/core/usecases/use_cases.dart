import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:web_translator_ml/core/error/failures.dart';

///The abstract class for the usecase to manage errors
// ignore: one_member_abstracts
abstract class UseCase<Type, Params> {
  ///The function to call the usecase
  Future<Either<Failure, Type>?> call(Params params);
}

///The abstract class for the usecase to manage errors when the class don't
///need params
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
