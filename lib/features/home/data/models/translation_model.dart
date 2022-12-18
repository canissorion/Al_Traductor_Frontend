// To parse this JSON data, do
//
//     final translationModel = translationModelFromJson(jsonString);

import 'dart:convert';

import 'package:web_translator_ml/features/home/domain/entities/translation_entity.dart';

TranslationModel translationModelFromJson(String str) =>
    TranslationModel.fromJson(json.decode(str) as Map<String, dynamic>);

String translationModelToJson(TranslationModel data) =>
    json.encode(data.toJson());

class TranslationModel extends TranslationEntity {
  const TranslationModel({required super.translation});

  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      TranslationModel(
        translation: json['translation'] as String,
      );

  TranslationModel copyWith({
    required String translation,
  }) =>
      TranslationModel(
        translation: translation,
      );

  Map<String, dynamic> toJson() => {
        'translation': translation,
      };
}
