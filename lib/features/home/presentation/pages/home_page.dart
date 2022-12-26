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
import 'package:web_translator_ml/features/home/presentation/widgets/history_button_widget.dart';
import 'package:web_translator_ml/features/home/presentation/widgets/idiom_selector_widget.dart';
import 'package:web_translator_ml/features/home/presentation/widgets/saved_button_wdiget.dart';
import 'package:web_translator_ml/features/home/presentation/widgets/settings_widget.dart';
import 'package:web_translator_ml/features/home/presentation/widgets/text_boxs_widget.dart';
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            getTranslateUseCase: getTranslate,
            getLenguageUseCase: getLenguageUseCase,
            getServerStatusUseCase: getStatusUseCase,
          ),
        )
      ],
      child: Scaffold(
        body: BlocConsumer<HomeBloc, HomeState>(
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
                  title: 'ERROR',
                  desc: 'No se pudo conectar con el servidor',
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
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
                /// Logo.png
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24.h, left: 136.w),
                      child: Container(
                        width: 300.w,
                        height: 80.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logo.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 113.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 136.w, bottom: 24.h),
                      child: GestureDetector(
                        onTap: () => SideSheet.right(
                          body: SettingsWidget(server: server),
                          context: context,
                          width: 0.4.sw,
                        ),
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
                            child: IdiomSelector(
                              state: state,
                            ),
                          ),
                        ),
                        TextBoxsWidget(
                          texto: texto,
                          state: state,
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
                    const HistoryButtonWidget(),
                    SizedBox(
                      width: 36.w,
                    ),
                    const SavedButtonWidget()
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
