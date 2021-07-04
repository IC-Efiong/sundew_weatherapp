import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FaIcon, FontAwesomeIcons;
import 'package:http/http.dart' as http;




void main () => runApp(
  MaterialApp(
    title: 'Sundew Weather App',
    home: Home(),
  )
);

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return Homestate();
  }
}

class Homestate extends State<Home>{

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather ()  async{
    http.Response response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=Lagos&appid=0f8c7ce761297deb17fa69052ca56df0'));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp =results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }
  @override
  void initState () {
    super.initState();
    this.getWeather();

  }
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height /4,
              width:  MediaQuery.of(context).size.width,
              color: Colors.greenAccent,
              child :Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Currently in Lagos',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 20.0,
                          fontWeight: FontWeight.w600

                      )
                    )

                  ),
                  Text(
                    temp != null ? temp.toString() + '\u00B0' : 'Loading',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 43.0,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                          currently != null ? currently.toString() : 'Loading',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600

                          )
                      )

                  ),
                ]

              )
    ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Weather'),
                    trailing: Text(description != null ? description.toString()  : 'Loading'),
                  ),
                  ListTile(
                    leading:FaIcon(FontAwesomeIcons.thermometerHalf),
                     title: Text('Temperature'),
                     trailing: Text(temp != null ? temp.toString() + '\u00B0' : 'Loading'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                     title: Text('Humidity'),
                     trailing: Text(humidity != null ? humidity.toString()  : 'Loading'),
                  ),
                  ListTile(
                    leading:FaIcon(FontAwesomeIcons.wind),
                    title :Text('Wind speed'),
                    trailing: Text(windSpeed != null ? windSpeed.toString()  : 'Loading'),
                  ),
                ],
              ),
            ),
          )

        ],

      ),

    );
  }
}