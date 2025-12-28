import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Theme/colors.dart';
import 'Theme/text_style.dart';
import 'Theme/button_style.dart';
import 'widgets/list_tile_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'models/dayWeatherModel.dart';
import 'today_TomorrowDataScreen.dart';

class DataViewPage extends StatefulWidget {
  final List<DayWeatherModel> weatherModel;

  const DataViewPage({Key? key, required this.weatherModel}) : super(key: key);
  @override
  State<DataViewPage> createState() => _DataViewPageState();
}

class _DataViewPageState extends State<DataViewPage> {
  int selectedindex = 0;

  String getWeatherBackground(String condition) {
    final c = condition.toLowerCase();

    if (c.contains('cloudy') || c.contains('overcast')) {
      return 'https://media.istockphoto.com/id/603174568/photo/the-indigo-blue-sky-over-the-city.jpg?s=612x612&w=0&k=20&c=p6hE6TyDl6hy6Wba3HkzBAuQRArsyOnIUSESaoLpe5g=';
    }

    if (c.contains('clear') || c.contains('sunny')) {
      return 'https://www.leinsterleader.ie/resizer/640/-1/true/GN4_DAT_9815138.jpg--sunny_weather_is_predicted_for_co__kildare_today.jpg';
    }

    if (c.contains('drizzle') || c.contains('rain')) {
      return 'https://media.istockphoto.com/id/498063665/photo/rainy-landscape.jpg?s=612x612&w=0&k=20&c=2KhHJguvlQvd83c-CJeOiuEKI323gbtSIf1n2sNdXJc=';
    }
    if (c.contains('snow')) {
      return 'https://images.stockcake.com/public/8/3/f/83f7f8de-0d22-44c5-8de1-2dff108e8a25_large/snowy-evening-road-stockcake.jpg';
    }

    return 'https://cbx-prod.b-cdn.net/COLOURBOX52714950.jpg?width=800&height=800&quality=70';
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String condition = widget.weatherModel[0].condition.toLowerCase();
    return Scaffold(
      appBar: PreferredSize(
        //make app bar height
        preferredSize: Size.fromHeight(height * 0.45),
        child: AppBar(
          // elevation: 0,
          title: Text(
            "${widget.weatherModel[0].Country}, ${widget.weatherModel[0].City} ",
            style: AppTextStyle.headline,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/search");
              },
              icon: Icon(Icons.search, color: AppColors.foreground),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
              image: DecorationImage(
                image: NetworkImage(getWeatherBackground(widget.weatherModel[0].condition)),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(22.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 70.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.weatherModel[0].temp.round()}\u00B0",
                        style: AppTextStyle.temprature,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https:${widget.weatherModel[0].condition_photo}',
                            height: 100.h,
                            width: 100.w,
                          ),
                          Text(
                            widget.weatherModel[0].condition,
                            style: AppTextStyle.body14.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.weatherModel[0].time.toString().substring(0, 16)}",
                        style: AppTextStyle.body14,
                      ),

                      ///date
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Day ${widget.weatherModel[0].max_temp.round()}\u00B0",
                            style: AppTextStyle.body14.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Night ${widget.weatherModel[0].min_temp.round()}\u00B0",
                            style: AppTextStyle.body14.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(60)),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(18.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedindex = 0;
                      });
                    },
                    style: selectedindex == 0
                        ? AppButtonStyle.selected
                        : AppButtonStyle.primary,
                    child: Text(
                      "Today",
                      style: AppTextStyle.btn_text.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedindex = 1;
                      });
                    },
                    style: selectedindex == 1
                        ? AppButtonStyle.selected
                        : AppButtonStyle.primary,
                    child: Text(
                      "Tomorrow",
                      style: AppTextStyle.btn_text.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),
              DayTomScreen(
                selectedindex: selectedindex,
                weatherModel: widget.weatherModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
