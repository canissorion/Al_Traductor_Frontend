part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({this.inicial, this.objetivo});
  final String? inicial;
  final String? objetivo;
  @override
  List<Object?> get props => [inicial, objetivo];
}

class HomeInitial extends HomeState {
  const HomeInitial({this.inicial, this.objetivo});
  final String? inicial;
  final String? objetivo;
}

class HomeWithServer extends HomeState {
  final bool status;
  final String? inicial;
  final String? objetivo;

  const HomeWithServer({required this.status, this.inicial, this.objetivo});

  @override
  List<Object?> get props => [status, inicial, objetivo];
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

  const HomeLoaded(
      {required this.translationEntity, this.inicial, this.objetivo});

  @override
  List<Object?> get props => [translationEntity, inicial, objetivo];
}
