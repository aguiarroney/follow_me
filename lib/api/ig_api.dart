import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:follow_me/models/user_model.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
import 'package:simple_auth_flutter/simple_auth_flutter.dart';
import 'package:http/http.dart' as http;

class IgApi{

  static const igClientSecret = "ACB";
  static const igClientId = "XPTO";
  static const igRedirectURI = "www.exemple.com";
  UserModelSingleton _user;

  final simpleAuth.InstagramApi _igApi = simpleAuth.InstagramApi(
    "instagram",
    igClientId,
    igClientSecret,
    igRedirectURI,
    scopes: [
      'user_profile',
      'user_media',
    ],
  );

  IgApi(BuildContext context){
    SimpleAuthFlutter.init(context);
  }

  Future<void> authenticate() async{
    http.Response  response = await _igApi.authenticate().then((user) async {
      simpleAuth.OAuthAccount localUser = user;
      return  http.get("https://graph.instagram.com/me?fields=username,id,account_type,media_count&access_token=${localUser.token}");
//      return  http.get("https://graph.instagram.com/me/follows?access_token=${localUser.token}");
    });

    if(response.statusCode == 200){
      var decoded = json.decode(response.body);
      print("!!!! response $decoded}");
      UserModelSingleton _user = UserModelSingleton();
      _user.setLog(true);
      _user.setAccountType(decoded["account_type"]);
      _user.setMidiaCount(decoded["media_count"]);
      _user.setId(decoded["id"]);
      _user.setUserName(decoded["username"]);

    }

  }
}