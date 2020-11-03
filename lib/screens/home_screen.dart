import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:follow_me/bloc/midia_bloc.dart';
import 'package:follow_me/bloc/user_bloc.dart';
import 'package:follow_me/models/text_model.dart';
import 'package:follow_me/models/user_model.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      UserBloc userBloc = UserBloc();
      MidiaBloc midiaBloc = MidiaBloc();

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 129, 56, 175) , //roxo
          title: TextCustom(text: "Follow Me"),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.assignment_ind),
              onPressed: (){
                userBloc.authenticate(context);
              },
            ),
          ],
        ),
          body: StreamBuilder<UserModelSingleton>(
            stream: userBloc.outPutUserController,
            initialData: UserModelSingleton(),
            builder: (context, snapshot) {
              return Stack(
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
                                  TextCustom(text: snapshot.data.getLogStatus() ? "@${snapshot.data.getUserName()}" : ""),
                                  Padding(padding: EdgeInsets.all(2),),
                                  TextCustom(text: snapshot.data.getMediaCount() != null ? "Midia: ${snapshot.data.getMediaCount()}" : ""),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    Positioned(
                        child: snapshot.data.getId() == null? Center(child: TextCustom(text: "Log in",)) : Container(
                        child: StreamBuilder<int>(
                          stream: midiaBloc.outPutIndexStreamController,
                          initialData: 0,
                          builder: (context, snapshot){
                            print("!!!! snapshot data: ${snapshot.data}");
                              return FutureBuilder<List<String>>(
                                future: userBloc.makeMidiaList(context),
                                builder: (context, snapshot){
                                  if(snapshot.hasData)
                                    return Container(
                                        width: 290,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(2)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Image.network(userBloc.user.getMidiaByIndex(midiaBloc.index),),
                                        )
                                    );
                                  else
                                    return Center(
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(2)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                }
                              );
                          }),
                      ),
                  ),
                  Positioned(
                    width: 290,
                    bottom: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: TextCustom(text: "Anterior"),
                          onTap: (){
                              midiaBloc.getPrevius();
                          },
                        ),
                        GestureDetector(
                          child: TextCustom(text: "Próximo"),
                            onTap: (){
                                midiaBloc.getNext();
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
      );
  }
}