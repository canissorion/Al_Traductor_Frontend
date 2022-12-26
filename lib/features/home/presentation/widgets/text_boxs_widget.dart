import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import 'package:web_translator_ml/features/home/presentation/bloc/home_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TextBoxsWidget extends StatelessWidget {
  const TextBoxsWidget({
    super.key,
    required this.texto,
    required this.state,
  });

  final TextEditingController texto;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    SpeechToText _speechToText = SpeechToText();
    FlutterTts flutterTts = FlutterTts();

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 34.w,
            right: 72.w,
            bottom: 35.h,
          ),
          child: Container(
            width: 550.w,
            height: 360.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(27.r),
                topRight: Radius.circular(27.r),
                bottomLeft: Radius.circular(27.r),
                bottomRight: Radius.circular(27.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(
                    0,
                    0,
                    0,
                    0.05000000074505806,
                  ),
                  offset: Offset(3, 4),
                  blurRadius: 10,
                )
              ],
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 21.h, right: 27.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final boxBookmark = await Hive.openBox('bookmark');
                          if (state is HomeLoaded) {
                            await boxBookmark.add(
                                'Original: ${texto.text} Traduccion: ${(state as HomeLoaded).translationEntity.translation}');
                          }
                        },
                        child: SvgPicture.asset(
                          'bookmark.svg',
                          height: 24.h,
                          width: 24.w,
                          color: const Color(0xFF9EADBE),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 29.w),
                  child: SizedBox(
                    width: 455.w,
                    height: 255.h,
                    child: TextField(
                      scribbleEnabled: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                      controller: texto,
                      decoration: InputDecoration(
                        hintText: 'Ingresar Texto',
                        hintStyle: TextStyle(
                          color: const Color(0xFF9EADBE),
                          fontSize: 18.sp,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.h, left: 29.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          print(state.sttOn);
                          print(state);
                          if (state.sttOn == null || state.sttOn == false) {
                            context.read<HomeBloc>().add(StartSTTEvent());
                            await _speechToText.initialize();
                            await _speechToText.listen(
                              onResult: (result) {
                                texto.text = result.recognizedWords;
                              },
                            );
                          }
                          if (state.sttOn != null && state.sttOn == true) {
                            /// emit event to turn off tts
                            context.read<HomeBloc>().add(StopSTTEvent());
                            await _speechToText.stop();
                          }
                        },
                        child: SvgPicture.asset(
                          'group1.svg',
                          height: 24.h,
                          width: 13.w,
                          fit: BoxFit.scaleDown,
                          color: state.sttOn == null
                              ? const Color(0xFF0975F4)
                              : state.sttOn == false
                                  ? const Color(0xFF0975F4)
                                  : Colors.red,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                        onPressed: () {
                          /// Emite el evento GetTranslateEvent
                          /// para obtener la traducción
                          if (state.inicial != null && state.objetivo != null) {
                            context.read<HomeBloc>().add(GetTranslationEvent(
                                text: texto.text,
                                sourceLanguage: state.inicial!,
                                targetLanguage: state.objetivo!,
                                model: (state.inicial == 'arn' ||
                                        state.objetivo == 'arn')
                                    ? 'ml'
                                    : 'cloud'));
                          }
                        },
                        child: const Text('Consultar'),
                      ),
                      SizedBox(
                        width: 29.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 34.w,
            bottom: 35.h,
          ),
          child: Container(
            width: 550.w,
            height: 360.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(27.r),
                topRight: Radius.circular(27.r),
                bottomLeft: Radius.circular(27.r),
                bottomRight: Radius.circular(27.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(
                    0,
                    0,
                    0,
                    0.05000000074505806,
                  ),
                  offset: Offset(3, 4),
                  blurRadius: 10,
                )
              ],
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    if (state is HomeLoaded)
                      Padding(
                        padding: EdgeInsets.only(
                          left: 29.w,
                          top: 45.h,
                        ),
                        child: Text(
                          (state as HomeLoaded).translationEntity.translation,
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    if (state is HomeError)
                      Padding(
                        padding: EdgeInsets.only(
                          left: 29.w,
                          top: 45.h,
                        ),
                        child: Text(
                          'No se pudo obtener la traducción',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(bottom: 18.h, left: 29.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (state.objetivo == 'en') {
                            await flutterTts.setLanguage('en-US');
                          }
                          if (state.objetivo == 'es') {
                            await flutterTts.setLanguage('es-ES');
                          }
                          flutterTts.setPitch(1);
                          flutterTts.setSpeechRate(0.5);
                          print(state.objetivo);
                          if (state is HomeLoaded && state.objetivo == 'arn') {
                            /// For each letter in the translation
                            /// we reproduce the phonema with AssetsAudioPlayer
                            for (var i = 0;
                                i <
                                    (state as HomeLoaded)
                                        .translationEntity
                                        .translation
                                        .length;
                                i++) {
                              if ((state as HomeLoaded)
                                      .translationEntity
                                      .translation[i] !=
                                  ' ') {
                                AssetsAudioPlayer _assetsAudioPlayer =
                                    AssetsAudioPlayer();
                                print(
                                  (state as HomeLoaded)
                                      .translationEntity
                                      .translation[i],
                                );
                                if ((state as HomeLoaded)
                                        .translationEntity
                                        .translation[i] ==
                                    'r') {
                                  await _assetsAudioPlayer.open(
                                    Audio(
                                      'assets/${(state as HomeLoaded).translationEntity.translation[i]}.mp3',
                                      pitch: 1,
                                      playSpeed: 3,
                                    ),
                                  );
                                } else {
                                  await _assetsAudioPlayer.open(
                                    Audio(
                                      'assets/${(state as HomeLoaded).translationEntity.translation[i]}.mp3',
                                      pitch: 1,
                                      playSpeed: 1.5,
                                    ),
                                  );
                                }
                                if ((state as HomeLoaded)
                                        .translationEntity
                                        .translation[i] ==
                                    'r') {
                                  await Future.delayed(
                                      Duration(milliseconds: 250));
                                } else {
                                  await Future.delayed(
                                      Duration(milliseconds: 500));
                                }
                              } else {
                                await Future.delayed(
                                    Duration(milliseconds: 100));
                              }
                            }
                          }
                          if (state is HomeLoaded && state.objetivo != 'arn') {
                            await flutterTts.speak((state as HomeLoaded)
                                .translationEntity
                                .translation);
                          }
                        },
                        child: const Icon(
                          Icons.speaker,
                          color: Color(0xFF0975F4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
