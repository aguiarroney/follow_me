
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:follow_me/api/ig_api.dart';
import 'package:follow_me/models/user_model.dart';

class UserBloc {

  UserModelSingleton user = UserModelSingleton();

  final StreamController<UserModelSingleton> _userController = StreamController<UserModelSingleton>();
  Sink get inputUserController => _userController.sink;
  Stream get outPutUserController => _userController.stream;

  void authenticate(BuildContext context) async{
    IgApi api = IgApi(context);
    api.authenticate();
    inputUserController.add(UserModelSingleton());
  }

}