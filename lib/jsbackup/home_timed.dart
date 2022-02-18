import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();

  var cityName;
  var dt;
  var actTime;
  var formattedTime;
  var temp;
  var description;
  var humidity;
  var windSpeed;
  var pressure;
  var icon;

  var cityName2;
  var dt2;
  var actTime2;
  var formattedTime2;
  var temp2;
  var description2;
  var humidity2;
  var windSpeed2;
  var pressure2;
  var icon2;

  var humidIndex, windIndex, presIndex;

  var searchedCity = 'chennai';

  Future getWeather() async {
    http.Response response = await http.get(
      Uri.parse(
          "http://api.openweathermap.org/data/2.5/weather?units=metric&appid=b0d14335762ac30b2189a45adc75237a&q=" +
              searchedCity),
    );

    var results = jsonDecode(response.body);

    setState(() {
      this.cityName = results['name'];

      this.dt = results['dt'];
      this.actTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
      this.formattedTime = DateFormat('yyyy-MM-dd – kk:mm').format(actTime);
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.pressure = results['main']['pressure'];

      this.humidIndex = (this.humidity / 100) * 100;
      this.windIndex = (this.windSpeed / 35) * 100;
      this.presIndex = (this.pressure / 1500) * 100;
    });
  }

  void getSearch(String text) {
    searchedCity = text;
    print('Searched: ' + searchedCity);
    this.getWeather();
    this.initState();
  }

  void reload() {
    this.getWeather();
    this.initState();
  }

  void initState() {
    super.initState();
    this.getWeather();
    Timer(Duration(minutes: 10), () {
      print('WeatherData Refreshed');
      this.reload();
    });
    //this.initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: 'Search City',
            contentPadding: EdgeInsets.all(10),
            //border: InputBorder.none,
          ),
          onEditingComplete: () {
            var city = _textEditingController.text;
            _textEditingController.clear();
            this.getSearch(city);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _textEditingController.clear();
              print('search cleared');
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      //drawer: Drawer(),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.greenAccent,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black12),
            ),

            //Below AppBar
            Container(
              padding: EdgeInsets.fromLTRB(10, 120, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
//City Name Display
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      cityName != null
                                          ? cityName.toString()
                                          : 'Loading...',
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      formattedTime != null
                                          ? formattedTime.toString()
                                          : 'Loading...',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

//Temperature Display
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          temp != null
                                              ? temp.toStringAsFixed(1)
                                              : "Loading...",
                                          style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '\u00B0C',
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    /*Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.wb_cloudy_outlined,
                                            color: Colors.white60,
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),*/
                                    Column(
                                      children: [
                                        Text(
                                          description != null
                                              ? description.toString()
                                              : "Loading...",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

//Bottom Contents
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                        ),
                      ),

//Bottom Info Bar-Humidity
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(WeatherIcons.humidity),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 5,
                                            width: 100,
                                            color: Colors.white10,
                                          ),
                                          Container(
                                            height: 5,
                                            width: humidIndex,
                                            color: Colors.blueAccent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    humidity != null
                                        ? humidity.toString()
                                        : "Loading...",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Text(
                                  '%',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

//Bottom Info Bar-Wind
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.air_outlined),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 5,
                                            width: 100,
                                            color: Colors.white10,
                                          ),
                                          Container(
                                            height: 5,
                                            width: windIndex,
                                            color: Colors.greenAccent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    windSpeed != null
                                        ? windSpeed.toString()
                                        : "Loading...",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Km/h',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

//Bottom Info Bar-Pressure
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(WeatherIcons.barometer),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 5,
                                            width: 100,
                                            color: Colors.white10,
                                          ),
                                          Container(
                                            height: 5,
                                            width: presIndex,
                                            color: Colors.orangeAccent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    pressure != null
                                        ? pressure.toString()
                                        : "Loading...",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Text(
                                  'mBar',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
