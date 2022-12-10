import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 241.h,
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
                            padding: EdgeInsets.only(top: 12.h),
                            child: SizedBox(
                              height: 49.h,
                              child: Text(
                                'Español',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 481.w,
                          ),
                          Container(
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
                          SizedBox(
                            width: 47.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: SizedBox(
                              height: 49.h,
                              child: Text(
                                'Mapudungun',
                                style: TextStyle(fontSize: 16.sp),
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
                                padding:
                                    EdgeInsets.only(top: 21.h, right: 27.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                      'bookmark.svg',
                                      height: 24.h,
                                      width: 24.w,
                                      color: const Color(0xFF9EADBE),
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
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    minLines: 1,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                    ),
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
                                children: [],
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
              Container(
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
                  'book.svg',
                  fit: BoxFit.scaleDown,
                  height: 28.h,
                  width: 28.h,
                ),
              ),
              SizedBox(
                width: 36.w,
              ),
              Container(
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
              )
            ],
          )
        ],
      ),
    );
  }
}
