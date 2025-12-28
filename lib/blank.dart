import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Theme/colors.dart';
import 'Theme/text_style.dart';

class Blank extends StatelessWidget {
  final String? msg;

  const Blank({super.key, this.msg});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: Icon(Icons.search, color: Colors.black , size: 30.r,),
          ),
        ],
      ),

      body: Center(
        child: Text(
          msg!=null ? 'No data to show, Search for your city' : '$msg',
          style: AppTextStyle.headline.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
