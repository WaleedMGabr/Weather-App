
import 'package:weatherapp/models/dayWeatherModel.dart';

class WeatherState{}

class NoWeatherState extends WeatherState{
  //GPS
}

class WeatherLoaded extends WeatherState{
  final List<DayWeatherModel> weatherModel;

  WeatherLoaded(this.weatherModel);


}

class WeatherFailed extends WeatherState{
  final String errormsg;

  WeatherFailed({required this.errormsg});

}
