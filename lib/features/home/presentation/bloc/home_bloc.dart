import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_translator_ml/core/usecases/use_cases.dart';
import 'package:web_translator_ml/features/home/domain/entities/lenguage_entity.dart';
import 'package:web_translator_ml/features/home/domain/entities/translation_entity.dart';
import 'package:web_translator_ml/features/home/domain/usecases/get_lenguage_usecase.dart';
import 'package:web_translator_ml/features/home/domain/usecases/get_status_usecase.dart';
import 'package:web_translator_ml/features/home/domain/usecases/get_translate_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
      {required this.getTranslateUseCase,
      required this.getLenguageUseCase,
      required this.getServerStatusUseCase})
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    /// Get Server Status
    on<GetServerStatusEvent>((event, emit) async {
      final result = await getServerStatusUseCase(NoParams());
      result!.fold(
        (failure) => emit(HomeInitial()),
        (status) => emit(
          HomeWithServer(
            status: status,
            inicial: state.inicial,
            objetivo: state.objetivo,
          ),
        ),
      );
    });

    /// Get Lenguages
    on<GetLenguageEvent>((event, emit) async {
      final result = await getLenguageUseCase(NoParams());
      result!.fold(
        (failure) => emit(HomeInitial()),
        (lenguages) =>
            emit(HomeWithLenguages(lenguageResponseEntity: lenguages)),
      );
    });

    on<GetTranslationEvent>((event, emit) async {
      final result = await getTranslateUseCase(TranslateParams(
        text: event.text,
        originLanguage: event.sourceLanguage,
        targetLanguage: event.targetLanguage,
        model: event.model,
      ));
      result!.fold(
        (failure) => emit(HomeError()),
        (translation) => emit(
          HomeLoaded(
            translationEntity: translation,
            inicial: event.sourceLanguage,
            objetivo: event.targetLanguage,
          ),
        ),
      );
    });

    /// Change Source Language
    on<ChangeSourceLanguageEvent>((event, emit) async {
      emit(
        HomeInitial(
          inicial: event.sourceLanguage,
          objetivo: state.objetivo,
        ),
      );
    });

    /// Change Target Language
    on<ChangeTargetLanguageEvent>((event, emit) async {
      emit(
        HomeInitial(
          inicial: state.inicial,
          objetivo: event.targetLanguage,
        ),
      );
    });

    /// Swap Languages
    on<SwapLanguagesEvent>((event, emit) async {
      emit(
        HomeInitial(
          inicial: state.objetivo,
          objetivo: state.inicial,
        ),
      );
    });

    /// Start STT
    on<StartSTTEvent>((event, emit) async {
      if (state is HomeWithServer) {
        emit(
          HomeWithServer(
            status: (state as HomeWithServer).status,
            inicial: state.inicial,
            objetivo: state.objetivo,
            sttOn: true,
          ),
        );
      }
      if (state is HomeLoaded) {
        emit(
          HomeLoaded(
            translationEntity: (state as HomeLoaded).translationEntity,
            inicial: state.inicial,
            objetivo: state.objetivo,
            sttOn: true,
          ),
        );
      }
    });

    /// Stop STT
    on<StopSTTEvent>((event, emit) async {
      if (state is HomeWithServer) {
        emit(
          HomeWithServer(
            status: (state as HomeWithServer).status,
            inicial: state.inicial,
            objetivo: state.objetivo,
            sttOn: false,
          ),
        );
      }
      if (state is HomeLoaded) {
        emit(
          HomeLoaded(
            translationEntity: (state as HomeLoaded).translationEntity,
            inicial: state.inicial,
            objetivo: state.objetivo,
            sttOn: false,
          ),
        );
      }
    });
  }

  GetTranslateUseCase getTranslateUseCase;
  GetLenguageUseCase getLenguageUseCase;
  GetServerStatusUseCase getServerStatusUseCase;
}
