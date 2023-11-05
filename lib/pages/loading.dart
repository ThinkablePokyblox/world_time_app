// Imports
import 'package:flutter/material.dart';
import 'package:world_time/services/worldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Loading
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}
class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    IpTime instance = IpTime(location: "N/A", flag: "N/A", url: "N/A", country: "N/A");
    await instance.getTime();
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
      'country': instance.country,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Text(
              'Loading..',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3,),
            Text(
              'Please wait',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 15,),
            SpinKitRotatingCircle(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

