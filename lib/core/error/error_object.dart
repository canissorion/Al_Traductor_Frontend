import 'package:equatable/equatable.dart';

import 'failures.dart';

/// The class for the usecase to manage errors
/// message: The default message defined by us to show to the user
/// errorMessage: Backend error message for the developer
class ErrorObject extends Equatable {
  const ErrorObject(
      {required this.title,
      required this.message,
      required this.errorMessage,
      required this.failureType});

  final String title;
  final String message;
  final String errorMessage;
  final Failure failureType;

  @override
  List<Object?> get props => [title, message];

  static ErrorObject mapFailureToErrorObject(
      {required Failure failure, required String errorMessage}) {
    return failure.when(
      internalServerFailure: () => ErrorObject(
          title: 'Error Code: INTERNAL_SERVER_FAILURE',
          message:
              'It seems that the server is not reachable at the moment, try '
              'again later',
          errorMessage: errorMessage,
          failureType: failure),
      dataParsingFailure: () => ErrorObject(
          title: 'Error Code: JSON_PARSING_FAILURE',
          message: 'It seems that the app needs to be updated to reflect the , '
              'changed server data structure',
          errorMessage: errorMessage,
          failureType: failure),
      noInternetFailure: () => ErrorObject(
          title: 'Error Code: NO_CONNECTIVITY',
          message: 'It seems that your device is not connected to the network, '
              'please check your internet connectivity or try again later.',
          errorMessage: errorMessage,
          failureType: failure),
      cacheFailure: () => ErrorObject(
          title: 'Error Code: CACHE_FAILURE',
          message: 'It seems that the cache is not reachable at the moment, '
              'try again later',
          errorMessage: errorMessage,
          failureType: failure),
      unauthorizedFailure: () => ErrorObject(
          title: 'Error Code: UNAUTHORIZED_FAILURE',
          message: 'It seems that you are not authorized to access this data, '
              'please check your credentials or try again later.',
          errorMessage: errorMessage,
          failureType: failure),
      badRequestFailure: () => ErrorObject(
          title: 'Error Code: BAD_REQUEST_FAILURE',
          message: 'It seems that the request is not valid, please check your '
              'request and try again later.',
          errorMessage: errorMessage,
          failureType: failure),
      notFoundFailure: () => ErrorObject(
          title: 'Error Code: NOT_FOUND_FAILURE',
          message: 'It seems that the resource is not found, please check your '
              'request and try again later.',
          errorMessage: errorMessage,
          failureType: failure),
      tooManyRequestsFailure: () => ErrorObject(
          title: 'Error Code: TOO_MANY_REQUESTS_FAILURE',
          message: 'It seems that you are making too many requests, please '
              'wait a few minutes and try again later.',
          errorMessage: errorMessage,
          failureType: failure),
      unknowFailure: () => ErrorObject(
          title: 'Error Code: UNKNOWN_FAILURE',
          message:
              'It seems that something went wrong, please try again later.',
          errorMessage: errorMessage,
          failureType: failure),
      deadlineExceededFailure: () => ErrorObject(
          title: 'Error Code: DEADLINE_EXCEEDED_FAILURE',
          message: 'It seems that the request took too long to complete, '
              'please try again later.',
          errorMessage: errorMessage,
          failureType: failure),
      cannotRealizeTaskFailure: () => ErrorObject(
          title: 'Error Code: CANNOT_REALIZE_TASK_FAILURE',
          message: 'It seems that the task cannot be realized, please try '
              'again later.',
          errorMessage: errorMessage,
          failureType: failure),
      missingTokenFailure: () => ErrorObject(
          title: 'Error Code: MISSING_TOKEN_FAILURE',
          message: 'It seems that the token is missing, please try again '
              'later.',
          errorMessage: errorMessage,
          failureType: failure),
      parsingResourceFailure: () => ErrorObject(
          title: 'Error Code: PARSING_RESOURCE_FAILURE',
          message:
              'It seems that the resource cannot be parsed, please try again later.',
          errorMessage: errorMessage,
          failureType: failure),
      emptyBodyFailure: () => ErrorObject(
          title: 'Error Code: EMPTY_BODY_FAILURE',
          message: 'It seems that the body is empty, please try again later.',
          errorMessage: errorMessage,
          failureType: failure),
      alreadyExistsFailure: () => ErrorObject(
          title: 'Error Code: ALREADY_EXISTS_FAILURE',
          message:
              'It seems that the resource already exists, please try again later.',
          errorMessage: errorMessage,
          failureType: failure),
    );
  }
}
