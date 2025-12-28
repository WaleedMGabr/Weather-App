import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtonStyle{
  static final primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.foreground,
    overlayColor: AppColors.foreground,
    minimumSize:  Size(120.w, 40.h),
    maximumSize:  Size(125.w, 40.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(12.r),
    )
  );

  static final selected = ElevatedButton.styleFrom(
      backgroundColor: AppColors.btn_highlight,
      overlayColor: AppColors.foreground,
      minimumSize:  Size(120.w, 40.h),
      maximumSize:  Size(125.w, 40.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12.r),
      )
  );
}