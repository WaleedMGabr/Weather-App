import 'package:bloc/bloc.dart';
import 'package:weatherapp/models/dayWeatherModel.dart';
import 'package:weatherapp/services/dayWeatherService.dart';
import 'getWeather_states.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class getWeatherCubit extends Cubit<WeatherState>{
  getWeatherCubit() : super(NoWeatherState());

  // late DayWeatherModel weatherModel;
  getWeather({required String cityName})async{
    try{
      List<DayWeatherModel> weatherModel = await DayWeatherService(Dio()).getCurrentWeather(cityname: cityName);
      emit(WeatherLoaded(weatherModel));
    } catch(e){
      emit(WeatherFailed(errormsg: e.toString()));
    }
  }

  getWeatherByLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(WeatherFailed(errormsg: 'Location services are disabled.'));
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(WeatherFailed(errormsg: 'Location permissions are denied'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(WeatherFailed(
            errormsg:
                'Location permissions are permanently denied, we cannot request permissions.'));
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        String? cityName = placemarks.first.locality;
        if (cityName != null && cityName.isNotEmpty) {
          await getWeather(cityName: cityName);
        } else {
          emit(WeatherFailed(errormsg: 'Could not determine city name from location.'));
        }
      } else {
        emit(WeatherFailed(errormsg: 'No placemarks found for your location.'));
      }
    } catch (e) {
      emit(WeatherFailed(errormsg: e.toString()));
    }
  }


}