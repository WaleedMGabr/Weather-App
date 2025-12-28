import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherapp/Theme/colors.dart';
import 'package:weatherapp/Theme/text_style.dart';
import 'package:weatherapp/models/dayWeatherModel.dart';
import 'package:weatherapp/widgets/list_tile_card.dart';

class DayTomScreen extends StatelessWidget {
  final int selectedindex;
  final List<DayWeatherModel> weatherModel;

  const DayTomScreen({
    super.key,
    required this.selectedindex,
    required this.weatherModel,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            selectedindex == 0
                ? ListTileCard(
                    title: "Wind speed",
                    subtitle: "${weatherModel[0].wind_speed}km/h",
                    icon: CupertinoIcons.wind,
                  )
                : ListTileCard(
                    title: "Wind speed",
                    subtitle: "${weatherModel[1].wind_speed}km/h",
                    icon: CupertinoIcons.wind,
                  ),
            selectedindex == 0
                ? ListTileCard(
                    title: "Rain chance",
                    subtitle: "${weatherModel[0].rain_chance}%",
                    icon: CupertinoIcons.cloud_rain,
                  )
                : ListTileCard(
                    title: "Rain chance",
                    subtitle: "${weatherModel[0].rain_chance}%",
                    icon: CupertinoIcons.cloud_rain,
                  ),
          ],
        ),
        SizedBox(height: 20.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            selectedindex == 0
                ? ListTileCard(
                    title: "cloud",
                    subtitle: "${weatherModel[0].cloud}%",
                    icon: Icons.cloud,
                  )
                : ListTileCard(
                    title: "cloud",
                    subtitle: "${weatherModel[1].cloud}%",
                    icon: Icons.cloud,
                  ),

            selectedindex == 0
                ? ListTileCard(
                    title: "Humidity",
                    subtitle: "${weatherModel[0].humidity}%",
                    icon: Icons.opacity,
                  )
                : ListTileCard(
                    title: "Humidity",
                    subtitle: "${weatherModel[1].humidity}%",
                    icon: Icons.opacity,
                  ),
          ],
        ),

        SizedBox(height: 30.h),

        Container(
          padding: EdgeInsetsGeometry.all(10.r),
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(20.r),
            color: AppColors.cardColor.withOpacity(0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsetsGeometry.all(5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(40.r),
                      color: AppColors.foreground,
                    ),
                    child: Icon(CupertinoIcons.time),
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    "Hourly forecast",
                    style: AppTextStyle.body14.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

             SizedBox(height: 20.h,),

             SizedBox(
               height: 165.h,
               child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: (weatherModel[selectedindex].hourlyData.length - now.hour)
                   ,itemBuilder: (context,index){
                      final item = weatherModel[selectedindex].hourlyData[index + now.hour];
                      return Container(
                        width: 80.w,
                        margin: EdgeInsetsGeometry.only(right: 8.w),
                        child: Column(
                          children: [
                            item.time.hour == now.hour ? Text("Now" , style: TextStyle(fontSize: 11 , fontWeight: FontWeight.bold),):
                            Text("${item.time.toString().substring(10,16)}"),
                            Image.network('https:${item.condition_photo}' , width: 50.w, height: 50.h,),
                            Text('${item.temp}'),
                          ],
                        ),

                      );
                   }),
             ),
            ],
          ),
        ),
      ],
    );
  }
}
