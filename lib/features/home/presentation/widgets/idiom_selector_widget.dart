import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_translator_ml/features/home/presentation/bloc/home_bloc.dart';

class IdiomSelector extends StatelessWidget {
  const IdiomSelector({
    super.key,
    required this.state,
  });

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    BlocProvider.of<HomeBloc>(context).add(
                      ChangeSourceLanguageEvent(
                        sourceLanguage: value,
                      ),
                    );
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('Ingles'),
                  ),
                  DropdownMenuItem(
                    value: 'es',
                    child: Text('Español'),
                  ),
                  DropdownMenuItem(
                    value: 'arn',
                    child: Text('Mapudungun'),
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
              borderRadius: BorderRadius.all(Radius.circular(13)),
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
                    BlocProvider.of<HomeBloc>(context).add(
                      ChangeTargetLanguageEvent(
                        targetLanguage: value,
                      ),
                    );
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('Ingles'),
                  ),
                  DropdownMenuItem(
                    value: 'es',
                    child: Text('Español'),
                  ),
                  DropdownMenuItem(
                    value: 'arn',
                    child: Text('Mapudungun'),
                  ),
                ],
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
