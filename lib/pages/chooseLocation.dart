// Imports
import 'package:flutter/material.dart';
import 'package:world_time/services/worldTime.dart';
import '../services/worldTimes.dart';
//ChooseLocation
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}
class _ChooseLocationState extends State<ChooseLocation> {

  // Updating time
  void updateTime(index) async {
    if (locations[index].runtimeType == IpTime) {
      IpTime instance = locations[index];
      await instance.getTime();
      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
        'country': instance.country,
      });
    } else {
      WorldTime instance = locations[index];
      await instance.getTime();
      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
        'country': instance.country,
      });
    }
  }

  // Loading Ip Time
  IpTime ipTime = locations[0];

  @override
  Widget build(BuildContext context) {
    ipTime.getTime();
    print("build function ran.");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Chose a location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: locations[index].runtimeType == IpTime ? Text("${locations[index].location} (${locations[index].country}) ") : Text("${locations[index].location} (${locations[index].country}) "),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
