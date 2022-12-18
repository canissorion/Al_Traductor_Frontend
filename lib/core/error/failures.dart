import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();
  const factory Failure.internalServerFailure() = InternalServerFailure;
  const factory Failure.dataParsingFailure() = DataParsingFailure;
  const factory Failure.noInternetFailure() = NoInternetFailure;
  const factory Failure.cacheFailure() = CacheFailure;
  const factory Failure.unauthorizedFailure() = UnauthorizedFailure;
  const factory Failure.deadlineExceededFailure() = DeadlineExceededFailure;
  const factory Failure.unknowFailure() = UnknowFailure;
  const factory Failure.notFoundFailure() = NotFoundFailure;
  const factory Failure.badRequestFailure() = BadRequestFailure;
  const factory Failure.tooManyRequestsFailure() = TooManyRequestsFailure;
  const factory Failure.emptyBodyFailure() = EmptyBodyFailure;
  const factory Failure.alreadyExistsFailure() = AlreadyExistsFailure;
  const factory Failure.parsingResourceFailure() = ParsingResourceFailure;
  const factory Failure.missingTokenFailure() = MissingTokenFailure;
  const factory Failure.cannotRealizeTaskFailure() = CannotRealizeTaskFailure;
}
