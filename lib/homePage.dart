import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blank.dart';
import 'package:weatherapp/cubit/get_weather_cubit/getWeather_states.dart';
import 'package:weatherapp/searchPage.dart';
import 'dataViewPage.dart';
import 'cubit/get_weather_cubit/getWeather_cubit.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<getWeatherCubit>(context).getWeatherByLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<getWeatherCubit,WeatherState>(builder: (context , state) {
        if (state is NoWeatherState) {  //no data{
          return Blank();
        }
        else if(state is WeatherLoaded) {
          return DataViewPage(weatherModel: state.weatherModel,);
        }
        else if(state is WeatherFailed) { ///edit to Weather Failed show errors but can go to search page
          return Blank( msg:
              'oops there was an error try again soon , ${state.errormsg}');
        }
        else {
          return Text('oops there was an error we fix it try again soon');
        }
      })
    );
  }
}
