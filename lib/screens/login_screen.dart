import 'package:flutter/cupertino.dart';
import 'package:follow_me/api/ig_api.dart';
import 'package:flutter/material.dart';
import 'package:follow_me/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      IgApi api = IgApi(context);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 129, 56, 175) , //roxo
          title: Text("Follow Me", style: GoogleFonts.juliusSansOne(fontWeight: FontWeight.w200),),
            elevation: 0,
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors:[
                          Color.fromARGB(255, 129, 56, 175), //roxo
                          Color.fromARGB(255, 245, 133, 41), //laranja
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 500,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1,),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text("Instagram", style: GoogleFonts.juliusSansOne(color: Colors.white)),
                              Padding(padding: EdgeInsets.all(2),),
                              Text( UserModelSingleton().getLogStatus() ? "nome de usuário: ${UserModelSingleton().getUserName()}" : "", style: GoogleFonts.juliusSansOne(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  child: RaisedButton(
                    color: Color.fromARGB(255, 245, 133, 41),
                    child: Text("log in", style: GoogleFonts.juliusSansOne(color: Colors.white)),
                    onPressed: (){
                      api.authenticate();
                    },
                  ),
                ),
              ),
            ],
          ),
      );
  }
}