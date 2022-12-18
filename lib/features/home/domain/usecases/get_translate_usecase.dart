import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:web_translator_ml/core/error/failures.dart';
import 'package:web_translator_ml/core/usecases/use_cases.dart';
import 'package:web_translator_ml/features/home/domain/entities/translation_entity.dart';
import 'package:web_translator_ml/features/home/domain/repositories/home_repository.dart';

/// Get Translate Use Case
@injectable
class GetTranslateUseCase
    implements UseCase<TranslationEntity, TranslateParams> {
  /// Get Translate Use Case
  const GetTranslateUseCase(this.repository);

  /// Repository of the home module
  final HomeRepository repository;

  @override
  Future<Either<Failure, TranslationEntity>?> call(
      TranslateParams params) async {
    return await repository.getTranslate(
      params.text,
      params.originLanguage,
      params.targetLanguage,
      params.model,
    );
  }
}

/// Params for Translate
class TranslateParams extends Equatable {
  /// Params for Translate
  const TranslateParams({
    required this.text,
    required this.originLanguage,
    required this.targetLanguage,
    required this.model,
  });

  /// Text to translate
  final String text;

  /// Origin Language
  final String originLanguage;

  /// Target Language
  final String targetLanguage;

  /// Model Cloud
  final String model;

  @override
  List<Object> get props => [text, originLanguage, targetLanguage, model];
}
