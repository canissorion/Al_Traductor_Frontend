import 'package:dartz/dartz.dart';
import 'package:web_translator_ml/core/error/failures.dart';
import 'package:web_translator_ml/features/home/domain/entities/lenguage_entity.dart';
import 'package:web_translator_ml/features/home/domain/entities/translation_entity.dart';

/// Repository of the home module
abstract class HomeRepository {
  /// Repository of the home module
  const HomeRepository();

  /// getTranslate
  /// We need a Text to translate, a origin language, a target language and the
  /// model Cloud for translate the text with Google Api and ml
  /// to translate with IA
  Future<Either<Failure, TranslationEntity>>? getTranslate(
    String text,
    String originLanguage,
    String targetLanguage,
    String model,
  );

  /// getLenguages
  /// Get all lenguages availables
  Future<Either<Failure, LenguageResponseEntity>>? getLenguages();

  /// getServerStatus
  /// Get the status of the server
  Future<Either<Failure, bool>>? getServerStatus();
}
