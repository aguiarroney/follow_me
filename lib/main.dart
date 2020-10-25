import 'package:flutter/material.dart';
import 'package:follow_me/screens/home_screen.dart';
import 'package:follow_me/screens/login_screen.dart';
import 'models/user_model.dart';

main(){
  UserModelSingleton user = UserModelSingleton();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: user.getLogStatus() ? HomeScreen() : LogInScreen() ,
  ));
}

