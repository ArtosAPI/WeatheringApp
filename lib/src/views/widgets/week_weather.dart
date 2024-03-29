import 'package:artums/src/constants.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:flutter/material.dart';

const TextStyle _defTextStyle = TextStyle(
    color: Color.fromRGBO(142, 142, 142, 1), fontFamily: 'Rubik', fontSize: 14);

class WeekWeather extends StatelessWidget {
  const WeekWeather({super.key, required this.weekWeather});

  final List<Weather> weekWeather;

  int dayForecast(int hour)
  {
    switch(hour)
    {
      case <= 2 && >= 0:
        return 1;
      case <= 5 && > 2:
        return 2;
      case <= 8 && > 5:
        return 3;
      case <= 12 && > 8:
        return 4;
      case <= 15 && > 12:
        return 5;
      case <= 18 && > 15:
        return 6;
      case <= 21 && > 18:
        return 7;
      case <= 24 && > 21:
        return 8;

      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.81),
          borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Next days',
                style: _defTextStyle,
              )),
          DailyForecast(
            dayWeather: weekWeather[7]
          ),
          DailyForecast(
            dayWeather: weekWeather[15],
          ),
          DailyForecast(
            dayWeather: weekWeather[23],
          ),
          DailyForecast(
            dayWeather: weekWeather[31],
          ),
          DailyForecast(
            dayWeather: weekWeather[39],
          ),
          const Gap(16),
        ],
      ),
    );
  }
}

class DailyForecast extends StatelessWidget {
  const DailyForecast({super.key, required this.dayWeather});

  final Weather dayWeather;

  IconData getWeatherIcon(int weatherCondCode) {
    switch (weatherCondCode) {
      case >= 200 && < 300:
        return weatherIcons[WeatherConditions.thunderstorm.index];
      case >= 300 && < 400:
        return weatherIcons[WeatherConditions.drizzle.index];
      case >= 500 && < 600:
        return weatherIcons[WeatherConditions.rain.index];
      case >= 600 && < 700:
        return weatherIcons[WeatherConditions.snow.index];
      case >= 700 && < 800:
        return weatherIcons[WeatherConditions.fog.index];
      case == 800:
        return weatherIcons[WeatherConditions.sunny.index];
      case == 801:
        return weatherIcons[WeatherConditions.partlyCloudy.index];
      case >= 802:
        return weatherIcons[WeatherConditions.cloudy.index];

      default:
        return weatherIcons[WeatherConditions.sunny.index];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: const Color.fromRGBO(210, 226, 246, 1),
            child: Icon(
              getWeatherIcon(dayWeather.weatherConditionCode!),
              size: 48,
            ),
          ),
          Container(
            width: 175,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 3),
                borderRadius: BorderRadius.circular(50)),
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  '${DateFormat('EEEE').format(dayWeather.date!)}, ${dayWeather.date!.day} ${DateFormat('MMM').format(dayWeather.date!)}',
                  style: _defTextStyle,
                ),
                Text(
                  '${dayWeather.temperature!.celsius!.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
