// Imports
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:world_time/services/worldTimes.dart';
// World Time
class WorldTime {

  String location;
  String time = "loading";
  String flag;
  String url;
  String country;
  bool isDayTime = false;

  WorldTime({ required this.location, required this.flag, required this.url, required this.country});

  Future<void> getTime() async {
    try {
      // Get time
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      // Get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);

      // DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Setting time
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (error) {
      print("Caught error: $error");
      time = "Failed to get time data. $error";
    }
  }
}
// Ip Time
class IpTime {
  String location;
  String time = "loading";
  String flag;
  String url;
  String country;
  bool isDayTime = false;

  IpTime({
    required this.location,
    required this.flag,
    required this.url,
    required this.country,
  });

  Future<void> getTime() async {
    try {
      // Get time
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/ip"));
      Map data = jsonDecode(response.body);

      // Set time
      url = data['timezone'];

      // Set Country / location / flag
      locations.forEach((element) {
        if (element.url == url) {
          country = "[Based on IP] ${element.country}";
          location = element.location;
          flag = element.flag;
        }
      });

      // Get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);

      // DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Setting time
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (error) {
      print("Caught error: $error");
      time = "Failed to get time data. $error";
    }
  }
}