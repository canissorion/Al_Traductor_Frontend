// To parse this JSON data, do
//
//     final languageResponseModel = languageResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:web_translator_ml/features/home/domain/entities/lenguage_entity.dart';

LanguageResponseModel languageResponseModelFromJson(String str) =>
    LanguageResponseModel.fromJson(json.decode(str) as Map<String, dynamic>);

class LanguageResponseModel extends LenguageResponseEntity {
  LanguageResponseModel({
    required super.languages,
  });

  LanguageResponseModel copyWith({
    required List<LanguageModel> languages,
  }) =>
      LanguageResponseModel(
        languages: languages,
      );

  factory LanguageResponseModel.fromJson(Map<String, dynamic> json) =>
      LanguageResponseModel(
        languages: List<LanguageModel>.from(json['languages']
            .map(LanguageModel.fromJson as Map<String, dynamic>) as Iterable),
      );
}

class LanguageModel extends LanguageEntity {
  LanguageModel({
    required super.name,
    required super.code,
    required super.models,
  });

  LanguageModel copyWith({
    required String name,
    required String code,
    required ModelsModel models,
  }) =>
      LanguageModel(
        name: name,
        code: code,
        models: models,
      );

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        name: json['name'] as String,
        code: json['code'] as String,
        models: ModelsModel.fromJson(json['models'] as Map<String, dynamic>),
      );
}

class ModelsModel extends ModelsEntity {
  ModelsModel({
    required super.cloud,
    required super.ml,
  });

  ModelsModel copyWith({
    required CloudModel cloud,
    required MlModel ml,
  }) =>
      ModelsModel(
        cloud: cloud,
        ml: ml,
      );

  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        cloud: CloudModel.fromJson(json['cloud'] as Map<String, dynamic>),
        ml: MlModel.fromJson(json['ml'] as Map<String, dynamic>),
      );
}

class CloudModel extends CloudEntity {
  CloudModel({
    required super.features,
    required super.exclude,
  });

  CloudModel copyWith({
    required List<String> features,
    required List<dynamic> exclude,
  }) =>
      CloudModel(
        features: features,
        exclude: exclude,
      );

  factory CloudModel.fromJson(Map<String, dynamic> json) => CloudModel(
        features: List<String>.from(json['features'].map((x) => x) as Iterable),
        exclude: List<dynamic>.from(json['exclude'].map((x) => x) as Iterable),
      );

  Map<String, dynamic> toJson() => {
        'features': List<dynamic>.from(features.map((x) => x)),
        'exclude': List<dynamic>.from(exclude.map((x) => x)),
      };
}

class MlModel extends MlEntity {
  MlModel({
    required super.features,
    required super.include,
  });

  MlModel copyWith({
    required List<String> features,
    required List<String> include,
  }) =>
      MlModel(
        features: features,
        include: include,
      );

  factory MlModel.fromJson(Map<String, dynamic> json) => MlModel(
        features: List<String>.from(json['features'].map((x) => x) as Iterable),
        include: List<String>.from(json['include'].map((x) => x) as Iterable),
      );

  Map<String, dynamic> toJson() => {
        'features': List<dynamic>.from(features.map((x) => x)),
        'include': List<dynamic>.from(include.map((x) => x)),
      };
}
