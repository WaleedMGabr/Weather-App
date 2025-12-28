import 'package:dio/dio.dart';
import 'package:weatherapp/models/dayWeatherModel.dart';

class DayWeatherService {
  final Dio dio;
  final String apikey = "6448d789ae794e56b18100603252911";
  final String baseURL = "https://api.weatherapi.com/v1";

  DayWeatherService(this.dio);

  Future<List<DayWeatherModel>> getCurrentWeather({required String cityname}) async {
    List<DayWeatherModel> tenDaysData =[];
    try{
      Response respone = await dio.get(
        '$baseURL/forecast.json?key=$apikey&q=$cityname&days=2',
      );
      for(int i=0 ; i<2 ; i++){
        DayWeatherModel dayweathermodel = DayWeatherModel.fromJson(respone.data, dayIndex: i);
        tenDaysData.add(dayweathermodel);
      }

      return tenDaysData;
    } on DioException catch(e){
      String message = e.response?.data['error']['message'] ?? "oops there was an error, try again later";
      throw Exception(message);
    }catch(e){
      throw Exception(e);
    }
  }
}
