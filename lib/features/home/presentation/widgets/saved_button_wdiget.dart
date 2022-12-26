import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:web_translator_ml/features/home/data/models/translation_model.dart';
import 'package:web_translator_ml/features/home/domain/entities/translation_entity.dart';

class SavedButtonWidget extends StatelessWidget {
  const SavedButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final boxHistory = await Hive.openBox('history');
        final boxOrigin = await Hive.openBox('origin');
        if (boxHistory.isNotEmpty && boxOrigin.isNotEmpty) {
          boxHistory.length;
          boxOrigin.length;
          final listOrigin = <String>[];
          final list = <TranslationEntity>[];
          for (var i = 0; i < boxHistory.length; i++) {
            list.add(
              TranslationModel.fromJson(
                jsonDecode(boxHistory.getAt(i) as String)
                    as Map<String, dynamic>,
              ),
            );
          }
          for (var i = 0; i < boxOrigin.length; i++) {
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 10.h,
                                    left: 10.w,
                                    right: 10.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(207, 45, 6, 201),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.r),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
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
                                        padding: EdgeInsets.only(
                                          top: 10.h,
                                          left: 10.w,
                                          right: 10.w,
                                        ),
                                        child: Text(
                                          list[index].translation,
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.white),
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
          borderRadius: BorderRadius.all(Radius.elliptical(64.r, 64.r)),
        ),
        child: SvgPicture.asset(
          'bookmark.svg',
          color: const Color(0xFF0975F4),
          fit: BoxFit.scaleDown,
          height: 28.h,
          width: 28.h,
        ),
      ),
    );
  }
}
