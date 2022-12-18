import 'package:dio/dio.dart';

class DataParsingException implements Exception {
  final String message;

  DataParsingException({required this.message});

  @override
  String toString() => message;
}

class NoInternetException implements DioError {
  NoInternetException(
      {required this.error,
      required this.requestOptions,
      required this.response,
      required this.stackTrace,
      required this.type});

  @override
  dynamic error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => (error?.toString() ?? '');
}

class CacheException implements Exception {}

class UnauthorizedException implements DioError {
  UnauthorizedException(
      {required this.error,
      required this.requestOptions,
      required this.response,
      required this.stackTrace,
      required this.type});

  @override
  dynamic error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => (error?.toString() ?? '');
}

class DeadlineExceededException implements DioError {
  DeadlineExceededException(
      {required this.error,
      required this.requestOptions,
      required this.response,
      required this.stackTrace,
      required this.type});

  @override
  dynamic error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => (error?.toString() ?? '');
}

class NotFoundException implements DioError {
  NotFoundException(
      {required this.error,
      required this.requestOptions,
      required this.response,
      required this.stackTrace,
      required this.type});

  @override
  dynamic error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => (error?.toString() ?? '');
}

class BadRequestException implements DioError {
  BadRequestException(
      {required this.error,
      required this.requestOptions,
      required this.response,
      required this.stackTrace,
      required this.type});

  @override
  dynamic error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => (error?.toString() ?? '');
}

class InternalServerErrorException implements DioError {
  InternalServerErrorException(
      {required this.error,
      required this.requestOptions,
      required this.response,
      required this.stackTrace,
      required this.type});

  @override
  dynamic error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => (error?.toString() ?? '');
}

class UnknownException implements Exception {}

class TooManyRequestsException implements DioError {
  TooManyRequestsException(
      {required this.error,
      required this.requestOptions,
      required this.response,
      required this.stackTrace,
      required this.type});

  @override
  dynamic error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => (error?.toString() ?? '');
}
