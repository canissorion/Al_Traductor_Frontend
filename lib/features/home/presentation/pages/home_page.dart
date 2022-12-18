import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:web_translator_ml/features/home/data/models/translation_model.dart';
import 'package:web_translator_ml/features/home/domain/entities/translation_entity.dart';
import 'package:web_translator_ml/features/home/domain/usecases/get_lenguage_usecase.dart';
import 'package:web_translator_ml/features/home/domain/usecases/get_status_usecase.dart';
import 'package:web_translator_ml/features/home/domain/usecases/get_translate_usecase.dart';
import 'package:web_translator_ml/features/home/presentation/bloc/home_bloc.dart';
import 'package:web_translator_ml/injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final getTranslate = getIt<GetTranslateUseCase>();

    /// getLenguageusecase
    final getLenguageUseCase = getIt<GetLenguageUseCase>();

    /// getStatusUseCase
    final getStatusUseCase = getIt<GetServerStatusUseCase>();
    final texto = TextEditingController();
    final server = TextEditingController();
    var inicial = null;
    var objetivo = null;
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(
          getTranslateUseCase: getTranslate,
          getLenguageUseCase: getLenguageUseCase,
          getServerStatusUseCase: getStatusUseCase,
        ),
        child: BlocConsumer<HomeBloc, HomeState>(
          listenWhen: (previous, current) {
            return true;
          },
          listener: (context, state) {
            // TODO: implement listener
          },
          buildWhen: (previous, current) {
            if (current is HomeWithServer) {
              if (current.status == true) {
                return true;
              } else {
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "ERROR",
                  desc: "No se pudo conectar con el servidor",
                  buttons: [
                    DialogButton(
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                    )
                  ],
                ).show();
                return false;
              }
            }
            return true;
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              /// Get Server Status
              BlocProvider.of<HomeBloc>(context).add(GetServerStatusEvent());
            }

            return Column(
              children: [
                SizedBox(
                  height: 193.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 136.w, bottom: 24.h),
                      child: GestureDetector(
                        onTap: () => SideSheet.right(
                            body: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Column(
                                children: [
                                  const Text('Configuración'),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextField(
                                    controller: server,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Dirección del servidor',
                                      hintText: 'localhost:5000',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                    width: 300.w,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final box =
                                            await Hive.openBox('settings');
                                        if (server.text.isNotEmpty) {
                                          await box.clear();
                                          await box.put('url', server.text);
                                          Navigator.pop(context);

                                          /// Get Server Status
                                          BlocProvider.of<HomeBloc>(context)
                                              .add(GetServerStatusEvent());
                                        }
                                      },
                                      child: const Text('Guardar'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            context: context,
                            width: 0.4.sw),
                        child: Icon(
                          Icons.settings,
                          size: 24.h,
                          color: const Color(0xFF9EADBE),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 136.w, right: 136.w),
                  child: Container(
                    width: 1240.w,
                    height: 500.h,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      color: Color.fromRGBO(217, 217, 217, 0.28999999165534973),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 34.w,
                            right: 34.w,
                            top: 25.h,
                            bottom: 36.h,
                          ),
                          child: Container(
                            width: 1172.w,
                            height: 44.h,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(13),
                                topRight: Radius.circular(13),
                                bottomLeft: Radius.circular(13),
                                bottomRight: Radius.circular(13),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                    3,
                                    13,
                                    65,
                                    0.10000000149011612,
                                  ),
                                  offset: Offset(0, 4),
                                  blurRadius: 10,
                                )
                              ],
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 29.w,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5.h),
                                  child: SizedBox(
                                    height: 49.h,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: const Text('Seleccionar'),
                                        value: state.inicial,
                                        onChanged: (value) {
                                          if (value != null) {
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(
                                              ChangeSourceLanguageEvent(
                                                sourceLanguage: value,
                                              ),
                                            );
                                          }
                                        },
                                        items: const [
                                          DropdownMenuItem(
                                            child: Text('Ingles'),
                                            value: 'en',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Español'),
                                            value: 'es',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Mapudungun'),
                                            value: 'arn',
                                          ),
                                        ],
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 425.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    /// Swap Languages
                                    BlocProvider.of<HomeBloc>(context).add(
                                      SwapLanguagesEvent(),
                                    );
                                  },
                                  child: Container(
                                    width: 36.h,
                                    height: 34.h,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF0975F4),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(13)),
                                    ),
                                    child: SvgPicture.asset(
                                      'change.svg',
                                      fit: BoxFit.scaleDown,
                                      height: 20.h,
                                      width: 20.h,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 47.w,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5.h),
                                  child: SizedBox(
                                    height: 49.h,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: const Text('Seleccionar'),
                                        value: state.objetivo,
                                        onChanged: (value) {
                                          if (value != null) {
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(
                                              ChangeTargetLanguageEvent(
                                                targetLanguage: value,
                                              ),
                                            );
                                          }
                                        },
                                        items: const [
                                          DropdownMenuItem(
                                            child: Text('Ingles'),
                                            value: 'en',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Español'),
                                            value: 'es',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Mapudungun'),
                                            value: 'arn',
                                          ),
                                        ],
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                        Row(
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
                                      padding: EdgeInsets.only(
                                          top: 21.h, right: 27.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final boxBookmark =
                                                  await Hive.openBox(
                                                      'bookmark');
                                              if (state is HomeLoaded) {
                                                await boxBookmark.add(
                                                    "Original: ${texto.text} Traduccion: ${state.translationEntity.translation}");
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
                                      padding: EdgeInsets.only(
                                          top: 18.h, left: 29.w),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'group1.svg',
                                            height: 24.h,
                                            width: 13.w,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          SizedBox(
                                            width: 11.w,
                                          ),
                                          SvgPicture.asset(
                                            'group.svg',
                                            fit: BoxFit.scaleDown,
                                            height: 24.h,
                                            width: 13.w,
                                          ),
                                          SizedBox(
                                            width: 11.w,
                                          ),
                                          SvgPicture.asset(
                                            'vector.svg',
                                            fit: BoxFit.scaleDown,
                                            height: 24.h,
                                            width: 13.w,
                                          ),
                                          const Expanded(child: SizedBox()),
                                          ElevatedButton(
                                            onPressed: () {
                                              /// Emite el evento GetTranslateEvent
                                              /// para obtener la traducción
                                              if (state.inicial != null &&
                                                  state.objetivo != null) {
                                                context.read<HomeBloc>().add(
                                                    GetTranslationEvent(
                                                        text: texto.text,
                                                        sourceLanguage:
                                                            state.inicial!,
                                                        targetLanguage:
                                                            state.objetivo!,
                                                        model: (state.inicial ==
                                                                    'arn' ||
                                                                state.objetivo ==
                                                                    'arn')
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
                                              state.translationEntity
                                                  .translation,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final boxHistory = await Hive.openBox('history');
                        final boxOrigin = await Hive.openBox('origin');
                        if (boxHistory.isNotEmpty && boxOrigin.isNotEmpty) {
                          boxHistory.length;
                          boxOrigin.length;
                          List<String> listOrigin = [];
                          List<TranslationEntity> list = [];
                          for (int i = 0; i < boxHistory.length; i++) {
                            list.add(
                              TranslationModel.fromJson(
                                  jsonDecode(boxHistory.getAt(i) as String)
                                      as Map<String, dynamic>),
                            );
                          }
                          for (int i = 0; i < boxOrigin.length; i++) {
                            listOrigin.add(boxOrigin.getAt(i) as String);
                          }
                          await showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) {
                              /// Return Container with Top Rounded Corners
                              /// and a height of 300
                              /// with a ListView inside
                              return Container(
                                height: 0.3.sh,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      'Historial de traducciones',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 0.3.sw,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: list.length,
                                            itemBuilder: (context, index) {
                                              /// Return a Container with rounded corners
                                              /// ocean blue background color
                                              /// with two text divided by a divider
                                              /// on top Origin text
                                              /// on bottom translated text
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    top: 10.h,
                                                    left: 10.w,
                                                    right: 10.w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        207, 45, 6, 201),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.r),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10.h,
                                                          left: 10.w,
                                                          right: 10.w,
                                                        ),
                                                        child: Text(
                                                          listOrigin[index],
                                                          style: TextStyle(
                                                            fontSize: 18.sp,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color: Colors.white,
                                                        thickness: 1,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10.h,
                                                          left: 10.w,
                                                          right: 10.w,
                                                        ),
                                                        child: Text(
                                                          list[index]
                                                              .translation,
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        width: 64.h,
                        height: 64.h,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            )
                          ],
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(64.r, 64.r)),
                        ),
                        child: SvgPicture.asset(
                          'book.svg',
                          fit: BoxFit.scaleDown,
                          height: 28.h,
                          width: 28.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final boxHistory = await Hive.openBox('history');
                        final boxOrigin = await Hive.openBox('origin');
                        if (boxHistory.isNotEmpty && boxOrigin.isNotEmpty) {
                          boxHistory.length;
                          boxOrigin.length;
                          List<String> listOrigin = [];
                          List<TranslationEntity> list = [];
                          for (int i = 0; i < boxHistory.length; i++) {
                            list.add(
                              TranslationModel.fromJson(
                                  jsonDecode(boxHistory.getAt(i) as String)
                                      as Map<String, dynamic>),
                            );
                          }
                          for (int i = 0; i < boxOrigin.length; i++) {
                            listOrigin.add(boxOrigin.getAt(i) as String);
                          }
                          await showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) {
                              /// Return Container with Top Rounded Corners
                              /// and a height of 300
                              /// with a ListView inside
                              return Container(
                                height: 0.3.sh,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      'Guardados',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 0.3.sw,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: list.length,
                                            itemBuilder: (context, index) {
                                              /// Return a Container with rounded corners
                                              /// ocean blue background color
                                              /// with two text divided by a divider
                                              /// on top Origin text
                                              /// on bottom translated text
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    top: 10.h,
                                                    left: 10.w,
                                                    right: 10.w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        207, 45, 6, 201),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.r),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10.h,
                                                          left: 10.w,
                                                          right: 10.w,
                                                        ),
                                                        child: Text(
                                                          listOrigin[index],
                                                          style: TextStyle(
                                                            fontSize: 18.sp,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color: Colors.white,
                                                        thickness: 1,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10.h,
                                                          left: 10.w,
                                                          right: 10.w,
                                                        ),
                                                        child: Text(
                                                          list[index]
                                                              .translation,
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        width: 64.h,
                        height: 64.h,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            )
                          ],
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(64.r, 64.r)),
                        ),
                        child: SvgPicture.asset(
                          'bookmark.svg',
                          color: const Color(0xFF0975F4),
                          fit: BoxFit.scaleDown,
                          height: 28.h,
                          width: 28.h,
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
