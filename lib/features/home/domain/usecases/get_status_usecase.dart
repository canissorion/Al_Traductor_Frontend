import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:web_translator_ml/core/error/failures.dart';
import 'package:web_translator_ml/core/usecases/use_cases.dart';
import 'package:web_translator_ml/features/home/domain/repositories/home_repository.dart';

/// Get Server Status Use Case
@injectable
class GetServerStatusUseCase implements UseCase<bool, NoParams> {
  /// Get Server Status Use Case
  const GetServerStatusUseCase(this.repository);

  /// Repository of the home module
  final HomeRepository repository;

  @override
  Future<Either<Failure, bool>?> call(NoParams params) async {
    return await repository.getServerStatus();
  }
}
