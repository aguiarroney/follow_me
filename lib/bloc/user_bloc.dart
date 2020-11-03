
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:follow_me/api/ig_api.dart';
import 'package:follow_me/models/user_model.dart';

class UserBloc {

  UserModelSingleton user = UserModelSingleton();

  final StreamController<UserModelSingleton> _userController = StreamController<UserModelSingleton>();
  Sink get inputUserController => _userController.sink;
  Stream get outPutUserController => _userController.stream;

  void authenticate(BuildContext context){
    IgApi _api = IgApi(context);
    _api.authenticate().then((value){
      inputUserController.add(UserModelSingleton());
    });

  }

  Future<List<String>> makeMidiaList(BuildContext context){
    IgApi _api = IgApi(context);
    return _api.makeMidiaIdList().then((value){
      inputUserController.add(UserModelSingleton());
      return UserModelSingleton().getMidiaUrl;
    });
  }

}