import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:follow_me/models/user_model.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
import 'package:simple_auth_flutter/simple_auth_flutter.dart';
import 'package:http/http.dart' as http;

class IgApi{

  static const igClientSecret = "824e5dcb3eb4f28b5407d2d4a581b985";
  static const igClientId = "276282983613850";
  static const igRedirectURI = "https://followme.com.br/";

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

  Future<UserModelSingleton> authenticate() async{
    simpleAuth.OAuthAccount localUser;

    http.Response response = await _igApi.authenticate().then((user) async {
      localUser = user;
      return  http.get("https://graph.instagram.com/me?fields=username,id,account_type,media_count&access_token=${localUser.token}");
    });

//    return response;

    if(response.statusCode == 200){
      var decoded = json.decode(response.body);
      print("!!!! response $decoded}");
      UserModelSingleton _user = UserModelSingleton();
      _user.setLog(true);
      _user.setAccountType(decoded["account_type"]);
      _user.setMidiaCount(decoded["media_count"]);
      _user.setId(decoded["id"]);
      _user.setUserName(decoded["username"]);
      _user.setToken(localUser.token);

      makeMidiaIdList();
    }

    return UserModelSingleton();
  }

  void makeMidiaIdList() async{
    UserModelSingleton _user = UserModelSingleton();

    http.Response midiaResponse = await http.get("https://graph.instagram.com/${_user.getId()}/media?access_token=${_user.getToken()}");

    if(midiaResponse.statusCode == 200){
      var decodedMidia = json.decode(midiaResponse.body);
      for (var item in decodedMidia["data"]){
        http.Response urlResponse = await http.get("https://graph.instagram.com/${item["id"]}?fields=id,media_type,media_url,username,timestamp&access_token=${_user.getToken()}");

        if(urlResponse.statusCode == 200){
          var urlDecoded = json.decode(urlResponse.body);
//          print("!!!! ${urlDecoded["media_url"]}");
          _user.addMidiaUrls(urlDecoded["media_url"]);
        }
      }
    }
  }
}