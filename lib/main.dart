import 'package:flutter/material.dart';
import 'package:weatherapp/Theme/colors.dart';
import 'package:weatherapp/cubit/get_weather_cubit/getWeather_cubit.dart';
import 'package:weatherapp/services/dayWeatherService.dart';
import 'homePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'searchPage.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => getWeatherCubit(),
          child: MaterialApp(
            title: 'Weather App',
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.background,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: "/home",
            routes: {
              "/home": (_) => MyHomePage(),
              "/search": (_) => SearchPage(),
            },
          ),
        );
      },
    );
  }
}