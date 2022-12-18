import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:web_translator_ml/core/error/error_object.dart';
import 'package:web_translator_ml/core/error/exceptions.dart';
import 'package:web_translator_ml/core/error/failures.dart';
import 'package:web_translator_ml/features/home/data/datasources/translate_datasource.dart';
import 'package:web_translator_ml/features/home/domain/entities/translation_entity.dart';
import 'package:web_translator_ml/features/home/domain/repositories/home_repository.dart';

import '../../domain/entities/lenguage_entity.dart';

/// Implementation of the [HomeRepository] interface
@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  /// Implementation of the [HomeRepository] interface
  const HomeRepositoryImpl(this.remoteDataSource);

  final TranslateDataSource remoteDataSource;

  @override
  Future<Either<Failure, TranslationEntity>>? getTranslate(
    String text,
    String originLanguage,
    String targetLanguage,
    String model,
  ) async {
    try {
      final translation = await remoteDataSource.getTranslate(
        text,
        originLanguage,
        targetLanguage,
        model,
      );
      return Right(translation);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data! is ErrorObject) {
        final errorObject = e.response!.data! as ErrorObject;
        return Left(errorObject.failureType);
      }
      return const Left(UnknowFailure());
    } on DataParsingException {
      return const Left(DataParsingFailure());
    } catch (e) {
      return const Left(UnknowFailure());
    }
  }

  @override
  Future<Either<Failure, LenguageResponseEntity>>? getLenguages() async {
    try {
      final lenguages = await remoteDataSource.getLenguages();
      return Right(lenguages);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data! is ErrorObject) {
        final errorObject = e.response!.data! as ErrorObject;
        return Left(errorObject.failureType);
      }
      return const Left(UnknowFailure());
    } on DataParsingException {
      return const Left(DataParsingFailure());
    } catch (e) {
      return const Left(UnknowFailure());
    }
  }

  @override
  Future<Either<Failure, bool>>? getServerStatus() async {
    try {
      final status = await remoteDataSource.getServerStatus();
      return Right(status);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data! is ErrorObject) {
        final errorObject = e.response!.data! as ErrorObject;
        return Left(errorObject.failureType);
      }
      return const Left(UnknowFailure());
    } on DataParsingException {
      return const Left(DataParsingFailure());
    } catch (e) {
      return const Left(UnknowFailure());
    }
  }
}
