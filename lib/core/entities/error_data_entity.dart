import 'package:equatable/equatable.dart';

class ErrorDataEntity extends Equatable {
  final String? code;
  final String? type;
  final String? detail;
  final int? status;
  final String? traceId;

  const ErrorDataEntity({
    this.code,
    this.type,
    this.detail,
    this.status,
    this.traceId,
  });

  @override
  List<Object?> get props => [code, type, detail, status, traceId];
}
