// ignore_for_file: overridden_fields, must_be_immutable

import 'package:web_translator_ml/core/entities/error_data_entity.dart';

class ErrorDataModel extends ErrorDataEntity {
  @override
  String? code;
  @override
  String? type;
  @override
  String? detail;
  @override
  int? status;
  @override
  String? traceId;

  ErrorDataModel({
    this.code,
    this.type,
    this.detail,
    this.status,
    this.traceId,
  }) : super(
            code: code,
            type: type,
            detail: detail,
            status: status,
            traceId: traceId);

  @override
  List<Object?> get props => [code, type, detail, status, traceId];

  ErrorDataModel copyWith({
    String? code,
    String? type,
    String? detail,
    int? status,
    String? traceId,
  }) {
    return ErrorDataModel(
      code: code ?? this.code,
      type: type ?? this.type,
      detail: detail ?? this.detail,
      status: status ?? this.status,
      traceId: traceId ?? this.traceId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'type': type,
      'detail': detail,
      'status': status,
      'traceId': traceId,
    };
  }

  factory ErrorDataModel.fromJson(Map<String, dynamic> json) {
    return ErrorDataModel(
      code: json['code'] as String?,
      type: json['type'] as String?,
      detail: json['detail'] as String?,
      status: json['status'] as int?,
      traceId: json['traceId'] as String?,
    );
  }
}
