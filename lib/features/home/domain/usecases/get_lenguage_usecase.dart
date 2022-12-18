import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:web_translator_ml/core/error/failures.dart';
import 'package:web_translator_ml/core/usecases/use_cases.dart';
import 'package:web_translator_ml/features/home/domain/entities/lenguage_entity.dart';
import 'package:web_translator_ml/features/home/domain/repositories/home_repository.dart';

/// Get Lenguage Use Case
@injectable
class GetLenguageUseCase implements UseCase<LenguageResponseEntity, NoParams> {
  /// Get Lenguage Use Case
  const GetLenguageUseCase(this.repository);

  /// Repository of the home module
  final HomeRepository repository;

  @override
  Future<Either<Failure, LenguageResponseEntity>?> call(NoParams params) async {
    return await repository.getLenguages();
  }
}
