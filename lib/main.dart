import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
import 'package:simple_auth_flutter/simple_auth_flutter.dart';
import 'package:dio/dio.dart';

main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {

  static const igClientId = "276282983613850";
//  static const igCientToken = IGQVJXRDJpLWwxMWpCazdjV1l4amJHVW9UZAEh6MkFmbDUwcWR5OGFELXdEdE5VWHBjcEYxTUNoWk1CVXFMSE0tQWhsUzNwcUtYVTR3SzByYU9sbEpJZA1JETmlhRlY4RTlsUDVZAWmVDZAmd0MmZAVY0dScwZDZD;
  static const igClientSecret = "824e5dcb3eb4f28b5407d2d4a581b985";
  static const igRedirectURI = "https://followme.com.br/";

  final simpleAuth.InstagramApi _igApi = simpleAuth.InstagramApi(
    "instagram",
    igClientId,
    igClientSecret,
    igRedirectURI,
    scopes: [
      'user_profile', // For getting username, account type, etc.
      'user_media', // For accessing media count & data like posts, videos etc.
    ],
  );

  @override
  Widget build(BuildContext context) {
    SimpleAuthFlutter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Follow Me"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Instagram"),
        ],
        ),
      floatingActionButton: FloatingActionButton(
          child: Text("log in"),
          onPressed: _getData,
      ),
    );
  }

  _getData() async {

    http.Response  response = await _igApi.authenticate().then((user) async {
      simpleAuth.OAuthAccount localUser = user;
      print("!!!! user ${localUser.token}");

//      return  http.get("https://graph.instagram.com/me?fields=username,id,account_type,media_count&access_token=${localUser.token}");
      return  http.get("https://graph.instagram.com/me/follows?access_token=${localUser.token}");
    });

    var decoded = json.decode(response.body);
    print("!!!! response $decoded}");

  }
}
