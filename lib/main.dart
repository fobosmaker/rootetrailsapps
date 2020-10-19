import 'package:flutter/material.dart';
import 'package:flutter_maps/src/screen/trail.dart';
import 'package:flutter_maps/src/screen/home.dart';
import 'package:flutter_maps/src/screen/maps_research.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        //no login
        '/home': (context) => HomeScreen(),
        '/trail': (context) => TrailScreen(),
        '/research':(context) => MapsResearchPage()
      }
  ));
}
