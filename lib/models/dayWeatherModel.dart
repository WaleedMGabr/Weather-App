class HourlyWeatherModel {
  final double temp;
  final String condition_photo;
  final DateTime time;

  HourlyWeatherModel({
    required this.temp,
    required this.condition_photo,
    required this.time,
  });

  factory HourlyWeatherModel.fromJson(json) {
    return HourlyWeatherModel(
      time: DateTime.parse(json['time']),
      temp: json['temp_c'],
      condition_photo: json['condition']['icon'],
    );
  }
}

class DayWeatherModel {
  final String Country;
  final String City;
  final double temp;
  final double max_temp;
  final double min_temp;
  final double wind_speed;
  final int rain_chance;
  final int humidity;
  final double cloud;
  final DateTime time;
  final String condition;
  final String condition_photo;
  final List<HourlyWeatherModel> hourlyData;

  DayWeatherModel({
    required this.Country,
    required this.City,
    required this.temp,
    required this.max_temp,
    required this.min_temp,
    required this.wind_speed,
    required this.rain_chance,
    required this.humidity,
    required this.time,
    required this.condition,
    required this.condition_photo,
    required this.cloud,
    required this.hourlyData,
  });

  factory DayWeatherModel.fromJson(json, {int dayIndex = 0}) {
    return DayWeatherModel(
      Country: json['location']['country'],
      City: json['location']['name'],
      temp: json['forecast']['forecastday'][dayIndex]['day']['avgtemp_c'],
      max_temp: json['forecast']['forecastday'][dayIndex]['day']['maxtemp_c'],
      min_temp: json['forecast']['forecastday'][dayIndex]['day']['mintemp_c'],
      wind_speed:
          json['forecast']['forecastday'][dayIndex]['day']['maxwind_kph'],
      rain_chance:
          json['forecast']['forecastday'][dayIndex]['day']['daily_chance_of_rain'],
      humidity: json['forecast']['forecastday'][dayIndex]['day']['avghumidity'],
      cloud: json['forecast']['forecastday'][dayIndex]['day']['totalprecip_mm'],
      time: DateTime.parse(json['current']['last_updated']),
      condition:
          json['forecast']['forecastday'][dayIndex]['day']['condition']['text'],
      condition_photo:
          json['forecast']['forecastday'][dayIndex]['day']['condition']['icon'],

      hourlyData: ( json['forecast']['forecastday'][dayIndex]['hour'] as List).map((h)=> HourlyWeatherModel.fromJson(h)).toList(),
    );
  }
}
