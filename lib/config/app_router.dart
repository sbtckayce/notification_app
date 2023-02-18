import 'package:flutter/material.dart';
import 'package:notification/screens/home/home_screen.dart';
import 'package:notification/screens/screens.dart';

class AppRouter{
  static Route onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return HomeScreen.route();
      case '/add_task':
        return AddTaskScreen.route();
      default:
        return _errorRoute();
    }
  }
  static Route _errorRoute(){
    return MaterialPageRoute(builder: (_)=>Scaffold(appBar: AppBar(title: Text('Error'),),));
  }
}