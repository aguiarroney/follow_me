
import 'dart:async';

class MidiaBloc {

  int index = 0;

  final StreamController<int> _indexStreamController = StreamController<int>();
  Sink get inputIndexStreamController => _indexStreamController.sink;
  Stream get outPutIndexStreamController => _indexStreamController.stream;

  void getNext(){
    index ++;
    inputIndexStreamController.add(index);
  }

  void getPrevius(){
    if(index > 0)
      index --;
    inputIndexStreamController.add(index);
  }

}