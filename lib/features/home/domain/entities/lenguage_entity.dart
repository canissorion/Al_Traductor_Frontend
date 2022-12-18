import 'package:equatable/equatable.dart';

class LenguageResponseEntity extends Equatable {
  LenguageResponseEntity({
    required this.languages,
  });

  List<LanguageEntity> languages;

  @override
  List<Object> get props => [languages];
}

class LanguageEntity {
  LanguageEntity({
    required this.name,
    required this.code,
    required this.models,
  });

  String name;
  String code;
  ModelsEntity models;
}

class ModelsEntity {
  ModelsEntity({
    required this.cloud,
    required this.ml,
  });

  CloudEntity cloud;
  MlEntity ml;
}

class CloudEntity {
  CloudEntity({
    required this.features,
    required this.exclude,
  });

  List<String> features;
  List<dynamic> exclude;
}

class MlEntity {
  MlEntity({
    required this.features,
    required this.include,
  });

  List<String> features;
  List<String> include;
}
