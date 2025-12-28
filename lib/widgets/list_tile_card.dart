import 'package:flutter/material.dart';
import 'package:weatherapp/Theme/text_style.dart';
import 'package:weatherapp/Theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ListTileCard extends StatelessWidget{
  final String title;
  final String subtitle;
  final IconData icon;

  const ListTileCard({super.key, required this.title, required this.subtitle, required this.icon});


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width *0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(20.r),
        color: AppColors.cardColor.withOpacity(0.5),
      ),
      child: ListTile(
        leading: Container(padding: EdgeInsetsGeometry.all(5.r),decoration: BoxDecoration(
          color: AppColors.foreground,
          borderRadius: BorderRadiusGeometry.circular(40.r),
        ) ,child: Icon(icon , size: 25.r,)),
        title: Text(title , style: AppTextStyle.body14.copyWith(color: Colors.black , fontWeight: FontWeight.bold),),
        subtitle: Text(subtitle, style: AppTextStyle.body14.copyWith(color: Colors.black),),
      ),
    );
  }


}