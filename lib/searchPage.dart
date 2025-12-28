import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherapp/cubit/get_weather_cubit/getWeather_cubit.dart';
import 'package:weatherapp/cubit/get_weather_cubit/getWeather_states.dart';
import 'Theme/button_style.dart';
import 'Theme/colors.dart';
import 'Theme/text_style.dart';
import 'services/dayWeatherService.dart';
import 'models/dayWeatherModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchPage extends StatelessWidget {
  TextEditingController _searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<getWeatherCubit,WeatherState>(
      listener: (context,state) {
        if(state is WeatherLoaded){
          Navigator.pop(context);
        }
        else if(state is WeatherFailed){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errormsg)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_outlined),
          ),
          title: Text(
            "search",
            style: AppTextStyle.headline.copyWith(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter your city",
                    label: Text("Enter your city"),
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5.w),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5.w, color: Colors.black),
                    ),
                    contentPadding: EdgeInsetsGeometry.all(25.r),
                  ),
                ),
          
                SizedBox(height: 30.h),
          
                ElevatedButton(
                  onPressed: () async{
                    if(_searchcontroller.text.trim().isEmpty)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No City Entered")),
                      );
                    else
                      BlocProvider.of<getWeatherCubit>(context).getWeather(cityName: _searchcontroller.text.trim());
                    // Navigator.pop(context); /// blockprovider.of(context).getWeather(cityname)
                  },
                  style: AppButtonStyle.primary,
                  child: Text(
                    "search",
                    style: AppTextStyle.btn_text.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
