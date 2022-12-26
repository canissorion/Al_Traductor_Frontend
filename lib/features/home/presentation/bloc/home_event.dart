part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetTranslationEvent extends HomeEvent {
  final String text;
  final String sourceLanguage;
  final String targetLanguage;
  final String model;

  const GetTranslationEvent({
    required this.text,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.model,
  });

  @override
  List<Object> get props => [text, sourceLanguage, targetLanguage, model];
}

/// Get the current status of the server.
class GetServerStatusEvent extends HomeEvent {}

/// Get the list of languages supported by the server.
class GetLenguageEvent extends HomeEvent {}

/// Change the source language.
class ChangeSourceLanguageEvent extends HomeEvent {
  final String sourceLanguage;

  const ChangeSourceLanguageEvent({required this.sourceLanguage});

  @override
  List<Object> get props => [sourceLanguage];
}

/// Change the target language.
class ChangeTargetLanguageEvent extends HomeEvent {
  final String targetLanguage;

  const ChangeTargetLanguageEvent({required this.targetLanguage});

  @override
  List<Object> get props => [targetLanguage];
}

/// Swap the source and target languages.
class SwapLanguagesEvent extends HomeEvent {}

/// STT Event
/// Event to start the speech to text process.
class StartSTTEvent extends HomeEvent {}

/// Evento to stop the speech to text process.
class StopSTTEvent extends HomeEvent {}
