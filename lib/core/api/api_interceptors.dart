import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:web_translator_ml/core/entities/error_data_entity.dart';
import 'package:web_translator_ml/core/error/error_object.dart';
import 'package:web_translator_ml/core/error/exceptions.dart';
import 'package:web_translator_ml/core/error/failures.dart';
import 'package:web_translator_ml/core/models/error_data_model.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    ErrorDataEntity errorDataEntity;
    Failure failure;
    try {
      Talker().critical(err.response!.data);
      errorDataEntity = ErrorDataModel.fromJson(
          err.response!.data["error"] as Map<String, dynamic>);
    } catch (e) {
      throw DataParsingException(message: e.toString());
    }
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        err.response!.data = ErrorObject.mapFailureToErrorObject(
          failure: const DeadlineExceededFailure(),
          errorMessage: err.response!.data['message'] != null
              ? err.response!.data['message'] as String
              : 'Undefined',
        );
        throw DeadlineExceededException(
          error: err.error,
          requestOptions: err.requestOptions,
          response: err.response,
          stackTrace: err.stackTrace,
          type: err.type,
        );
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            if (errorDataEntity.code == '12') {
              failure = const EmptyBodyFailure();
            } else if (errorDataEntity.code == '13') {
              failure = const AlreadyExistsFailure();
            } else if (errorDataEntity.code == '14') {
              failure = const AlreadyExistsFailure();
            } else {
              failure = const BadRequestFailure();
            }
            err.response!.data = ErrorObject.mapFailureToErrorObject(
              failure: failure,
              errorMessage: err.response!.data['message'] != null
                  ? err.response!.data['message'] as String
                  : 'Undefined',
            );
            throw BadRequestException(
              error: err.error,
              requestOptions: err.requestOptions,
              response: err.response,
              stackTrace: err.stackTrace,
              type: err.type,
            );
          case 401:
            if (errorDataEntity.code == '41') {
              failure = const ParsingResourceFailure();
            } else if (errorDataEntity.code == '42') {
              failure = const MissingTokenFailure();
            } else {
              failure = const UnauthorizedFailure();
            }
            err.response!.data = ErrorObject.mapFailureToErrorObject(
              failure: failure,
              errorMessage: err.response!.data['message'] != null
                  ? err.response!.data['message'] as String
                  : 'Undefined',
            );
            throw UnauthorizedException(
              error: err.error,
              requestOptions: err.requestOptions,
              response: err.response,
              stackTrace: err.stackTrace,
              type: err.type,
            );
          case 500:
            err.response!.data = ErrorObject.mapFailureToErrorObject(
              failure: const InternalServerFailure(),
              errorMessage: err.response!.data['message'] != null
                  ? err.response!.data['message'] as String
                  : 'Undefined',
            );
            throw InternalServerErrorException(
              error: err.error,
              requestOptions: err.requestOptions,
              response: err.response,
              stackTrace: err.stackTrace,
              type: err.type,
            );
          case 404:
            err.response!.data = ErrorObject.mapFailureToErrorObject(
              failure: const NotFoundFailure(),
              errorMessage: err.response!.data['message'] != null
                  ? err.response!.data['message'] as String
                  : 'Undefined',
            );
            throw NotFoundException(
              error: err.error,
              requestOptions: err.requestOptions,
              response: err.response,
              stackTrace: err.stackTrace,
              type: err.type,
            );
          case 429:
            err.response!.data = ErrorObject.mapFailureToErrorObject(
              failure: const TooManyRequestsFailure(),
              errorMessage: err.response!.data['message'] != null
                  ? err.response!.data['message'] as String
                  : 'Undefined',
            );
            throw TooManyRequestsException(
              error: err.error,
              requestOptions: err.requestOptions,
              response: err.response,
              stackTrace: err.stackTrace,
              type: err.type,
            );
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        err.response!.data = ErrorObject.mapFailureToErrorObject(
          failure: const NoInternetFailure(),
          errorMessage: err.response!.data['message'] != null
              ? err.response!.data['message'] as String
              : 'Undefined',
        );
        throw NoInternetException(
          error: err.error,
          requestOptions: err.requestOptions,
          response: err.response,
          stackTrace: err.stackTrace,
          type: err.type,
        );
      default:
        err.response!.data = ErrorObject.mapFailureToErrorObject(
          failure: const UnknowFailure(),
          errorMessage: err.response!.data['message'] != null
              ? err.response!.data['message'] as String
              : 'Undefined',
        );
        throw UnknownException();
    }

    return handler.reject(err);
  }
}
