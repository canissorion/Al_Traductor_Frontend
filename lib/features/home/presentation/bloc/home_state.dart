part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({this.inicial, this.objetivo, this.sttOn});
  final String? inicial;
  final String? objetivo;
  final bool? sttOn;
  @override
  List<Object?> get props => [inicial, objetivo, sttOn];
}

class HomeInitial extends HomeState {
  const HomeInitial({this.inicial, this.objetivo});
  final String? inicial;
  final String? objetivo;
}

class HomeError extends HomeState {}

class HomeWithServer extends HomeState {
  final bool status;
  final String? inicial;
  final String? objetivo;
  final bool? sttOn;

  const HomeWithServer(
      {required this.status, this.inicial, this.objetivo, this.sttOn});

  @override
  List<Object?> get props => [status, inicial, objetivo, sttOn];
}

class HomeWithLenguages extends HomeState {
  final LenguageResponseEntity lenguageResponseEntity;

  const HomeWithLenguages({required this.lenguageResponseEntity});

  @override
  List<Object> get props => [lenguageResponseEntity];
}

class HomeLoaded extends HomeState {
  final TranslationEntity translationEntity;
  final String? inicial;
  final String? objetivo;
  final bool? sttOn;

  const HomeLoaded(
      {required this.translationEntity,
      this.inicial,
      this.objetivo,
      this.sttOn});

  @override
  List<Object?> get props => [translationEntity, inicial, objetivo, sttOn];
}
