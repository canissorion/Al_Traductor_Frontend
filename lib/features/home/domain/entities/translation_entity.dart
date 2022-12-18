import 'package:equatable/equatable.dart';

class TranslationEntity extends Equatable {
  const TranslationEntity({required this.translation});

  final String translation;

  @override
  List<Object> get props => [translation];
}
