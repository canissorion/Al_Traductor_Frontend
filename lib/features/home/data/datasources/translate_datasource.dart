import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:web_translator_ml/core/api/client.dart';
import 'package:web_translator_ml/core/error/exceptions.dart';
import 'package:web_translator_ml/features/home/data/models/lenguage_model.dart';
import 'package:web_translator_ml/features/home/data/models/translation_model.dart';
import 'package:web_translator_ml/features/home/domain/entities/lenguage_entity.dart';
import 'package:web_translator_ml/features/home/domain/entities/translation_entity.dart';

/// TranslateDataSource
abstract class TranslateDataSource {
  /// TranslateDataSource
  const TranslateDataSource();

  /// getTranslate
  /// We need a Text to translate, a origin language, a target language and the
  /// model Cloud for translate the text with Google Api and ml
  /// to translate with IA
  Future<TranslationEntity> getTranslate(
    String text,
    String originLanguage,
    String targetLanguage,
    String model,
  );

  /// getLenguages
  /// Get all lenguages availables
  Future<LenguageResponseEntity> getLenguages();

  /// getServerStatus
  /// Get the status of the server
  Future<bool> getServerStatus();
}

/// Implementation of the [TranslateDataSource] interface
/// Implement getTranslate
/// Dio Client
/// Injectable as [TranslateDataSource]
@Injectable(as: TranslateDataSource)
class TranslateDataSourceImpl implements TranslateDataSource {
  /// Implementation of the [TranslateDataSource] interface
  /// Implement getTranslate
  /// Dio Client
  /// Injectable as [TranslateDataSource]
  TranslateDataSourceImpl(this.client);

  final Client client;

  /// The [Dio] instance to use.
  late final Dio _client = client.init();

  @override
  Future<TranslationEntity> getTranslate(
    String text,
    String originLanguage,
    String targetLanguage,
    String model,
  ) async {
    try {
      final box = await Hive.openBox('settings');
      if (box.isNotEmpty) {
        final url = box.get('url');
        final response = await _client.post(
          '$url/translate',
          options: Options(
            headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
          ),
          data: {
            'text': text,
            'from': originLanguage,
            'to': targetLanguage,
            'model': model,
          },
        );
        if (response.statusCode == 200) {
          try {
            final boxOrigin = await Hive.openBox('origin');
            await boxOrigin.add(text);
            final boxHistory = await Hive.openBox('history');
            await boxHistory.add(json.encode(response.data));
            return TranslationModel.fromJson(
                response.data as Map<String, dynamic>);
          } catch (e) {
            throw DataParsingException(message: e.toString());
          }
        } else {
          throw UnknownException();
        }
      } else {
        throw CacheException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LenguageResponseEntity> getLenguages() async {
    try {
      final box = await Hive.openBox('settings');
      if (box.isNotEmpty) {
        final url = box.get('url');
        final response = await _client.get(
          '$url/languages',
          options: Options(
            headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
          ),
        );
        if (response.statusCode == 200) {
          try {
            return LanguageResponseModel.fromJson(
              response.data as Map<String, dynamic>,
            );
          } catch (e) {
            throw DataParsingException(message: e.toString());
          }
        } else {
          throw UnknownException();
        }
      } else {
        throw CacheException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> getServerStatus() async {
    try {
      final box = await Hive.openBox('settings');
      if (box.isNotEmpty) {
        final url = box.get('url');
        final response = await _client.get(
          '$url/connection',
          options: Options(
            headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
          ),
        );
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
