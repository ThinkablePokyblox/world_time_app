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

  // Search result handling
  TextEditingController SearchFilterTextController = TextEditingController();
  List<dynamic>FilteredLocations = [];
  void FilterLocations() {
    FilteredLocations.clear();
    locations.forEach((element) {
      if (element.location.toString().toLowerCase().indexOf(SearchFilterTextController.text.toLowerCase()) == 0 || element.country.toString().toLowerCase().indexOf(SearchFilterTextController.text.toLowerCase()) == 0) {
        FilteredLocations.add(element);
      }
      });
    print(FilteredLocations);
  }

  // Updating time
  void updateTime(index) async {
    if (FilteredLocations[index].runtimeType == IpTime) {
      IpTime instance = FilteredLocations[index];
      await instance.getTime();
      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
        'country': instance.country,
      });
    } else {
      WorldTime instance = FilteredLocations[index];
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
    FilterLocations();
    print("build function ran.");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Chose a location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          SizedBox(
            width: 1200,
            child: TextFormField(
              controller: SearchFilterTextController,
              onChanged: (value) {
                setState(() {
                  FilterLocations();
                });
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent, width: 1)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue, width: 3)
                ),
                filled: true,
                fillColor: Colors.blue[100],
                label: Icon(
                  Icons.search,
                  color: Colors.blue,
                  size: 35.0,
                  semanticLabel: "Search",
                )
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: FilteredLocations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        updateTime(index);
                      },
                      title: FilteredLocations[index].runtimeType == IpTime ? Text("${FilteredLocations[index].location} (${FilteredLocations[index].country}) ") : Text("${FilteredLocations[index].location} (${FilteredLocations[index].country}) "),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/${FilteredLocations[index].flag}'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}