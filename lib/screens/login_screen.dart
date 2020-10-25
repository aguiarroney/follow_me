import 'package:follow_me/api/ig_api.dart';
import 'package:flutter/material.dart';
import 'package:follow_me/models/user_model.dart';

class LogInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      IgApi api = IgApi(context);
      return Scaffold(
        appBar: AppBar(
          title: Text("Follow Me"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text("Instagram"),),
            Center(child: Text("nome de usuário: ${UserModelSingleton().getUserName()}"),),
            RaisedButton(
              child: Text("log in"),
              onPressed: (){
                  api.authenticate();
              },
            ),
          ],
        ),

      );
  }
}