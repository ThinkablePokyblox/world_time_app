//Imports
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//Home
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {

  Map<dynamic, dynamic> data = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;

    //Background
    String backgroundImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color BackgroundColor = data['isDayTime'] ? Colors.blue : Colors.indigo;

    //Time loading error
    Widget timeText;
    if (data['time'].toString().substring(0,6) == "Failed") {
      timeText = Text(
        'Failed to load time data.',
        style: TextStyle(
            color: Colors.redAccent,
            fontSize: 22
        ),
      );
    } else {
      timeText = Text(
        data["time"],
        style: TextStyle(
          fontSize: 66,
          color: Colors.white,
        ),
      );
    }

    // Page
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$backgroundImage'),
              fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag'],
                          'country': result['country'],
                        };
                      });
                      },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                        'Edit Location',
                      style: TextStyle(
                          color: Colors.grey[300]
                      ),
                    )
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5,),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/${data['flag']}"),
                      radius: 13,
                    ),
                  ],
                ),
                SizedBox(height: 2.0,),
                Text(
                  data['country'],
                  style: TextStyle(
                    fontSize: 10.0,
                    letterSpacing: 2.0,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 20.0,),
                timeText,
                SizedBox(height: 20.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
